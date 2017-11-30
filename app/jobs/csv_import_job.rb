require 'csv'
require 'zip'

class CsvImportJob < ApplicationJob
  queue_as :default
  @@logger = ActiveSupport::Logger.new(Rails.root.join("public/csv/CsvImport.log"))

  def perform(*args)
    @@logger.info('-----start:' + Time.zone.now.to_s + '-----')
    return unless abstract_zip
    return unless File.exist?(get_filepath('manifest'))
    csv_data = CSV.read(get_filepath('manifest'), headers: false)
    manifest_hash = Hash[*csv_data.flatten]
    csv_files = validate_manifest(manifest_hash)
    return if csv_files.nil? or csv_files.length < 1 
    ActiveRecord::Base.transaction do
    csv_files.each{|cf|
      cl = class_from_name(cf)
      csv_to_db(cf, cl) unless cl.nil?
    }
    end
    csv_to_backup
    @@logger.info('-----csv imported:' + Time.zone.now.to_s + '-----')
  end
  
  private
  def class_from_name(str)
    case str
    when 'academicSessions'
      return AcademicSession
    when 'classes'
      return Rclass
    when 'courses'
      return Course
    when 'enrollments'
      return Enrollment
    when 'orgs'
      return Org
    when 'users'
      return User
    when 'categories'
      return nil
    when 'classResources'
      return nil
    when 'courseResources'
      return nil
    when 'demographics'
      return nil
    when 'lineItems'
      return nil
    when 'resources'
      return nil
    when 'results'
      return nil
    else
      return nil
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
    backuppath = File.join('backup' , File.stat(check_file).mtime.strftime('%Y%m%d%H%M%S').to_s)
    FileUtils.mkdir_p(backuppath) unless FileTest.exist?(backuppath)
    Dir.glob('*.csv'){|f|
      FileUtils.mv(f, File.join(backuppath,f))
    }
  end
  
  def extract_to_csv
    FileUtils.cd(Rails.root.join(CSV_FILE_PATH))
    return nil unless File.exist?(CSV_ZIP_FILE)
    Zip::File.open(CSV_ZIP_FILE) do |zip|
      zip.each do |entry|
        zip.extract(entry, entry.name){ true }
      end
    end
  end

  def backup_zipfile
    FileUtils.cd(Rails.root.join(CSV_FILE_PATH))
    return nil unless File.exist?(CSV_ZIP_FILE)
    backup_file_name = File.stat(CSV_ZIP_FILE).mtime.strftime('%Y%m%d%H%M%S').to_s + '.zip'
    FileUtils.mkdir_p(BACKUP_DIR) unless FileTest.exist?(BACKUP_DIR)
    Dir.glob(CSV_ZIP_FILE){|f|
      FileUtils.mv(f, File.join(BACKUP_DIR,backup_file_name))
    }
  end

  def csv_to_db(fn, cl)
    cl.delete_all
    CSV.foreach(get_filepath(fn), headers: true, encoding: 'UTF-8') do |row|
      cl.create!(row.to_hash)
    end
    @@logger.info fn + " => " + cl.all.size.to_s
  end

  def get_filepath(type)
    Rails.root.join(CSV_FILE_PATH, type + '.csv').to_s
  end
  
  # bulk only
  def validate_manifest(manifest_hash)
    manifest_version = manifest_hash['manifest.version']
    oneroster_version = manifest_hash['oneroster.version']
    return nil unless '1'.eql?(manifest_version)
    return nil unless '1.1'.eql?(oneroster_version)
    read_files = []
    ROSTER_FILES.each{|fcl|
      read_files.push(fcl) if 'bulk'.eql?(manifest_hash['file.' + fcl])
    }
    read_files
  end
end