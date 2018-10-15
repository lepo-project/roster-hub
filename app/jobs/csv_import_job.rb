require 'csv'
require 'zip'

class CsvImportJob < ApplicationJob # rubocop:disable Metrics/ClassLength
  queue_as :default

  def perform(*)
    @logger = ActiveSupport::Logger.new(Rails.root.join(CSV_IMPORT_LOG))
    @logger.info('-----start:' + Time.zone.now.to_s + '-----')
    return unless abstract_zip
    return unless File.exist?(get_filepath('manifest'))
    csv_data = CSV.read(get_filepath('manifest'), headers: false)
    manifest_hash = Hash[*csv_data.flatten]
    csv_files = validate_manifest(manifest_hash)
    @logger.info("STOP:Invalid manifest") if csv_files.nil? || csv_files.empty?
    return if csv_files.nil? || csv_files.empty?
    @logger.info("-A5-")
    ActiveRecord::Base.transaction do
      csv_files.each do |cf|
        cl = class_from_name(cf)
        csv_to_db(cf, cl) unless cl.nil?
      end
    end
    csv_to_backup
    @logger.info('-----csv imported:' + Time.zone.now.to_s + '-----')
    check_consistency
  end

  private

  def class_from_name(str)
    case str
    when 'academicSessions'
      AcademicSession
    when 'classes'
      Rclass
    when 'courses'
      Course
    when 'enrollments'
      Enrollment
    when 'users'
      User
    when 'orgs'
      Org
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
    cl.delete_all
    CSV.foreach(get_filepath(fn), headers: true, encoding: 'UTF-8') do |row|
      hash = row.to_hash
      split_fullname(hash) if (cl == User) && FULLNAME_IN_FAMILYNAME
      hash.select! { |k, _| cl.column_names.include? k }
      cl.create!(hash)
    end
    @logger.info fn + ' => ' + cl.all.size.to_s
  end

  def split_fullname(hash)
    fullname = hash['familyName']
    space_index = fullname.index(/[[:blank:]]/)
    if space_index.nil?
      hash['familyName'] = fullname
      hash['givenName'] = ''
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

  # consistency check
  def check_consistency
    @logger.info('-----Check start:' + Time.zone.now.to_s + '-----')
    # check_course
    consistency_of_course
    # check enrollment
    consistency_of_enrollment
    # check class
    consistency_of_class
    @logger.info('-----Check end:' + Time.zone.now.to_s + '-----')
  end

  def consistency_of_course
    Course.find_each do |course|
      org = Org.find_by(sourcedId: course.orgSourcedId)
      logger_err('Course', course.sourcedId, ['orgSourcedId']) if org.nil?
    end
  end

  def consistency_of_enrollment
    Enrollment.find_each do |enrollment|
      err = []
      org = Org.find_by(sourcedId: enrollment.schoolSourcedId)
      err.push('orgSourcedId') if org.nil?
      rclass = Rclass.find_by(sourcedId: enrollment.classSourcedId)
      err.push('classSourcedId') if rclass.nil?
      user = User.find_by(sourcedId: enrollment.userSourcedId)
      err.push('userSourcedId') if user.nil?
      logger_err('Enrollment', enrollment.sourcedId, err) if err.present?
    end
  end

  def consistency_of_class
    Rclass.find_each do |rclass|
      err = []
      course = Course.find_by(sourcedId: rclass.courseSourcedId)
      err.push('courseSourceId') if course.nil?
      as = AcademicSession.find_by(sourcedId: rclass.termSourcedIds)
      err.push('termSourcedId') if as.nil?
      org = Org.find_by(sourcedId: rclass.schoolSourcedId)
      err.push('orgSourcedId') if org.nil?
      logger_err('Class', rclass.sourcedId, err) if err.present?
    end
  end

  def logger_err(objname, id, errstr_array)
    return if errstr_array.empty?
    errstr = errstr_array.join(', ')
    @logger.info 'ERROR:' + objname + ' sourcedId=' + id + ' has invalid ' + errstr
  end
end
