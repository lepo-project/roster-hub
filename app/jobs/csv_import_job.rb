require 'csv'
require 'zip'

class CsvImportJob < ApplicationJob # rubocop:disable Metrics/ClassLength
  queue_as :default

  def perform(*)
    @logger = ActiveSupport::Logger.new(Rails.root.join(CSV_IMPORT_LOG))
    @logger.info('-----CSV import start:' + Time.zone.now.to_s + '-----')
    return unless abstract_zip
    return unless File.exist?(get_filepath('manifest'))
    csv_data = CSV.read(get_filepath('manifest'), headers: false)
    manifest_hash = Hash[*csv_data.flatten]
    csv_files = validate_manifest(manifest_hash)
    @logger.info('STOP:Invalid manifest') if csv_files.nil? || csv_files.empty?
    return if csv_files.nil? || csv_files.empty?
    @logger.info('-A5-')
    @db_adapter = ActiveRecord::Base.connection.adapter_name.downcase
    csv_sourcedIds = {}
    ActiveRecord::Base.transaction do
      csv_files.each do |cf|
        cl = class_from_name(cf)
        csv_sourcedIds[cf] = csv_to_db(cf, cl) unless cl.nil?
      end
      destroy_unused Rclass, {termSourcedIds: csv_sourcedIds['academicSessions']}, csv_sourcedIds['classes']
      destroy_unused Enrollment, {classSourcedId: csv_sourcedIds['classes']}, csv_sourcedIds['enrollments']
    end
    csv_to_backup
    @logger.info('-----CSV import end:' + Time.zone.now.to_s + '-----')
  end

  private

  def destroy_unused(cl, condition, csv_sourcedIds)
    db_sourcedIds = cl.where(condition.merge({application_id: 0})).pluck('sourcedId')
    db_sourcedIds.reject!{|id| csv_sourcedIds.include? id}
    unless db_sourcedIds.empty?
      cl.where(sourcedId: db_sourcedIds).destroy_all
      @logger.info("Deleted from #{cl.table_name} => #{db_sourcedIds.size}")
    end
  end

  def class_from_name(str)
    case str
    when 'academicSessions', 'courses', 'enrollments', 'users', 'orgs'
      str.singularize.camelize.constantize
    when 'classes'
      Rclass
    end
  end

  def abstract_zip
    return true unless ZIP_MODE # continue importing process if ZIP_MODE=false
    return false if extract_to_csv.nil? # stop processing if zip file not exists
    backup_zipfile
    true
  end

  def csv_to_backup
    FileUtils.cd(Rails.root.join(CSV_FILE_PATH))
    check_file = 'manifest.csv'
    return unless File.exist?(check_file)
    timestamp = File.stat(check_file).mtime.strftime('%Y%m%d%H%M%S')
    backuppath = File.join('backup', timestamp)
    #backuppath = BACKUP_DIR
    FileUtils.mkdir_p(backuppath) unless FileTest.exist?(backuppath)
    Dir.glob('*.csv') do |f|
      FileUtils.mv(f, File.join(backuppath, f))
    end
  end

  def extract_to_csv
    FileUtils.cd(Rails.root.join(CSV_FILE_PATH))
    return nil unless File.exist?(CSV_ZIP_FILE)
    Zip::File.open(CSV_ZIP_FILE) do |zip|
      zip.each do |entry|
        zip.extract(entry, entry.name) { true }
      end
    end
  end

  def backup_zipfile
    FileUtils.cd(Rails.root.join(CSV_FILE_PATH))
    return nil unless File.exist?(CSV_ZIP_FILE)
    timestamp = File.stat(CSV_ZIP_FILE).mtime.strftime('%Y%m%d%H%M%S')
    backup_file_name = timestamp + '.zip'
    FileUtils.mkdir_p(BACKUP_DIR) unless FileTest.exist?(BACKUP_DIR)
    Dir.glob(CSV_ZIP_FILE) do |f|
      FileUtils.mv(f, File.join(BACKUP_DIR, backup_file_name))
    end
  end

  def csv_to_db(fn, cl)
    fullname_flag = (cl == User) && FULLNAME_IN_FAMILYNAME
    ids = []
    instances = []
    CSV.foreach(get_filepath(fn), headers: true, encoding: 'UTF-8') do |row|
      hash = row.to_hash
      split_fullname(hash) if fullname_flag
      hash.select! { |k, _| cl.column_names.include? k }
      ids.push hash['sourcedId']
      instances.push cl.new(hash)
    end
    update_columns = cl.column_names.reject{|c| %w[id sourcedId created_at].include? c}

    case @db_adapter
    when 'mysql', 'mysql2'
      # bulk update for MySQL and MariaDB
      result = cl.import instances, on_duplicate_key_update: update_columns
    when 'postgresql', 'sqlite'
      # bulk update for PostgreSQL (9.5+) and SQLite (3.24.0+)
      result = cl.import instances, on_duplicate_key_update: {conflict_target: [:sourcedId], columns: update_columns}
    end

    result.failed_instances.each do |fi|
      fi.errors.messages.each_key do |erk|
        @logger.warn " ERROR: #{cl.name} sourcedId=#{fi.sourcedId} has invalid #{erk.to_s}"
      end
    end
    @logger.info "Imported to #{cl.table_name} => #{instances.size - result.failed_instances.size}"
    ids
  end

  def split_fullname(hash)
    fullname = hash['familyName']
    space_index = fullname.index(/[[:space:]]/)
    if space_index.nil?
      hash['familyName'] = fullname
      hash['givenName'] = fullname
    else
      hash['familyName'] = fullname[0..(space_index - 1)]
      # Delete spaces before and after the given name
      hash['givenName'] = fullname[(space_index + 1)..(fullname.length - 1)].gsub(/(^[[:space:]]+)|([[:space:]]+$)/, '')
    end
  end

  def get_filepath(type)
    Rails.root.join(CSV_FILE_PATH, type + '.csv').to_s
  end

  # bulk only
  def validate_manifest(manifest_hash)
    manifest_version = manifest_hash['manifest.version']
    oneroster_version = manifest_hash['oneroster.version']
    return nil unless VERSION_OF_MANIFEST.eql?(manifest_version)
    return nil unless VERSION_OF_ONEROSTER.eql?(oneroster_version)
    read_files = []
    ROSTER_FILES.each do |fcl|
      read_files.push(fcl) if 'bulk'.eql?(manifest_hash['file.' + fcl])
    end
    read_files
  end
end
