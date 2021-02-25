require 'csv'
require 'zip'

class CsvImportJob < ApplicationJob # rubocop:disable Metrics/ClassLength
  queue_as :default

  def perform(*)
    @logger = ActiveSupport::Logger.new(Rails.root.join(CSV_IMPORT_LOG))
    @logger.info("----- Start CSV import job: #{Time.zone.now} -----")
    return unless zip_to_csv
    return unless File.exist?(get_filepath('manifest'))

    manifest_table = CSV.read(get_filepath('manifest'), headers: true)
    csv_files = validate_manifest manifest_table
    if csv_files.nil? || csv_files.empty?
      @logger.warn('Error: Invalid manifest')
      return
    end

    @db_adapter = ActiveRecord::Base.connection.adapter_name.downcase
    csv_sourcedIds = {}
    ActiveRecord::Base.transaction do
      csv_files.each do |cf|
        cl = filename_to_class cf
        csv_sourcedIds[cf] = csv_to_db(cf, cl) unless cl.nil?
      end
      destroy_unused Rclass, { termSourcedIds: csv_sourcedIds['academicSessions'] }, csv_sourcedIds['classes']
      destroy_unused Enrollment, { classSourcedId: csv_sourcedIds['classes'] }, csv_sourcedIds['enrollments']
    end
    # backup zip file or csv files depending on the value of ZIP_MODE
    ZIP_MODE ? remove_csv : backup_csv
    @logger.info("----- End CSV import job: #{Time.zone.now} -----")
  end

  private

  def destroy_unused(cls, condition, csv_sourcedIds)
    db_sourcedIds = cls.where(condition.merge({ application_id: 0 })).pluck('sourcedId')
    db_sourcedIds.reject! { |id| csv_sourcedIds.include? id }
    return if db_sourcedIds.empty?

    cls.where(sourcedId: db_sourcedIds).destroy_all
    @logger.info("Deleted from #{cls.table_name} => #{db_sourcedIds.size}")
  end

  def filename_to_class(str)
    case str
    when 'academicSessions', 'courses', 'enrollments', 'users', 'orgs'
      str.singularize.camelize.constantize
    when 'classes'
      Rclass
    end
  end

  def zip_to_csv
    return true unless ZIP_MODE # continue importing process if ZIP_MODE=false
    return false if extract_to_csv.nil? # stop processing if zip file does not exist

    backup_zip
    true
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

  def backup_csv
    FileUtils.cd(Rails.root.join(CSV_FILE_PATH))
    check_file = 'manifest.csv'
    return unless File.exist?(check_file)

    timestamp = File.stat(check_file).mtime.strftime('%Y%m%d%H%M%S')
    backuppath = File.join(CSV_BACKUP_DIR, timestamp)
    FileUtils.mkdir_p(backuppath) unless FileTest.exist?(backuppath)
    Dir.glob('*.csv') do |f|
      FileUtils.mv(f, File.join(backuppath, f))
    end
  end

  def backup_zip
    FileUtils.cd(Rails.root.join(CSV_FILE_PATH))
    return nil unless File.exist?(CSV_ZIP_FILE)

    timestamp = File.stat(CSV_ZIP_FILE).mtime.strftime('%Y%m%d%H%M%S')
    backup_file_name = "#{timestamp}.zip"
    FileUtils.mkdir_p(CSV_BACKUP_DIR) unless FileTest.exist?(CSV_BACKUP_DIR)
    Dir.glob(CSV_ZIP_FILE) do |f|
      FileUtils.mv(f, File.join(CSV_BACKUP_DIR, backup_file_name))
    end
  end

  def remove_csv
    FileUtils.cd(Rails.root.join(CSV_FILE_PATH))
    Dir.glob('*.csv') do |f|
      FileUtils.rm(f)
    end
  end

  def csv_to_db(csv_file, cls)
    metadata_flag = METADATA[csv_file.to_sym].present?
    fullname_flag = (cls == User) && FULLNAME_IN_FAMILYNAME
    sourcedIds = []
    instances = []
    CSV.foreach(get_filepath(csv_file), headers: true, encoding: 'UTF-8') do |row|
      hash = row.to_hash
      metadata_to_json(hash, METADATA[csv_file.to_sym].keys) if metadata_flag
      split_fullname(hash) if fullname_flag
      hash.select! { |k, _| cls.column_names.include? k }
      sourcedIds.push hash['sourcedId']
      instances.push cls.new(hash)
    end
    update_columns = cls.column_names.reject { |c| %w[sourcedId created_at].include? c }

    case @db_adapter
    when 'mysql', 'mysql2'
      # bulk update for MySQL and MariaDB
      result = cls.import instances, on_duplicate_key_update: update_columns
    when 'postgresql', 'sqlite'
      # bulk update for PostgreSQL (9.5+) and SQLite (3.24.0+)
      update_columns = update_columns.reject { |c| %w[updated_at].include? c }
      result = cls.import instances, on_duplicate_key_update: { conflict_target: ['"sourcedId"'], columns: update_columns }
    end

    result.failed_instances.each do |fi|
      fi.errors.messages.each_key do |erk|
        @logger.warn " ERROR: #{cls.name} sourcedId=#{fi.sourcedId} has invalid #{erk}"
      end
    end
    @logger.info "Imported to #{cls.table_name} => #{instances.size - result.failed_instances.size}"
    sourcedIds
  end

  def metadata_to_json(hash, metadata)
    hashed_metadata = metadata.map { |md| [md.to_s, hash["metadata.#{md}"]] }.to_h
    hash['metadata'] = hashed_metadata.to_json
    metadata.map { |md| hash.delete(md) }
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
    Rails.root.join(CSV_FILE_PATH, "#{type}.csv").to_s
  end

  # bulk only
  def validate_manifest(manifest_table)
    manifest = manifest_table.to_a.to_h
    return nil unless VERSION_OF_MANIFEST.eql?(manifest['manifest.version'])
    return nil unless VERSION_OF_ONEROSTER.eql?(manifest['oneroster.version'])

    read_files = []
    ROSTER_FILES.each do |fcl|
      read_files.push(fcl) if 'bulk'.eql?(manifest["file.#{fcl}"])
    end
    read_files
  end
end
