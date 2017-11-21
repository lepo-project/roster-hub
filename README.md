# OneRoster1.1 CSV import and API  
*Under development*

# Setting
[config/initializers/constants.rb]
CSV_FILE_PATH=':rails_root/public/csv'

# Install
$ bundle install  
$ rails db:migrate  

# Start the server.
$ rails s

# CSV Import

1. copy the csv fiels in the CSV_FILE_PATH  

2. execute importing csv files to the database.
(execute now)  
$ rails console  
> CsvImportJob.perform_now

# Get data with API

1. Get Access Token to use API.  

1.1 Register the client with uid and secret.  
'uid' and 'secret' are important.  

> app = Doorkeeper::Application.new :name=>'applicationname',:redirect_uri=>'http://xxxxx/', :uid=>'[uid]',:secret=>'[secret]'  
> app.save  

1.2 Get Access Token with uid and secret.  
$  curl -i http[s]://[servername][:port]/oauth/token -F grant_type="client_credentials" -F client_id="[uid]" -F client_secret="[secret]"  
{"access_token":"[accesstoken]","token_type":"bearer","expires_in":nil,"created_at":1510711311}  

2. Call API with access token.  
$ curl -i http[s]://[servername][:port]/ims/oneroster/v1p1/[endpoint]?[parameters&]access_token=[accesstoken]


