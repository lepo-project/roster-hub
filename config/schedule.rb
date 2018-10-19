set :output, "#{path}/log/cron_log.log"
set :environment,:production

every 1.day, at: ['5:10 am'] do
  runner 'CsvImportJob.perform_now'
end
