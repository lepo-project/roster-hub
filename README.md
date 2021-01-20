# RosterHub

## About
RosterHub is an open-source roster management system for mainly educational institutions.
The goal of RosterHub is to support interoperating the educational systems effectively by utilizing the learning information of SIS (Student Information System).
Main features are followings.

* CSV to REST API converter for learning information based on [IMS OneRoster v1.1 standard](https://www.imsglobal.org/oneroster-v11-final-specification "OneRoster v1.1 Final Specification")
* Roster management function for educational apps by original REST API

For more information, see the links in the [References](#References).

NOTICE: RosterHub is currently under development status.


## Setting
- Configure some constants.
```
[config/initializers/constants.rb]  
APIDOC = 'doc/apidoc.json'.freeze
CSV_BACKUP_DIR = 'backup'.freeze
CSV_FILE_PATH = 'storage/csv'.freeze
CSV_IMPORT_LOG = 'log/csv_import.log'.freeze
CSV_ZIP_FILE = 'oneroster.zip'.freeze
LIMIT = 100
OFFSET = 0
VERSION_OF_MANIFEST = '1.0'.freeze
VERSION_OF_ONEROSTER = '1.1'.freeze
ROSTER_FILES = %w[academicSessions categories demographics orgs resources courses users classes courseResources classResources enrollments lineItems results].freeze
METADATA = {}.freeze
ZIP_MODE = true
INCLUDE_CLASSES = %w[].freeze
EXCLUDE_CLASSES = %w[].freeze
```

- To disable basic authorization for access tokens,
it is needed to configure doorkeeper's access_token_methods.

```
[config/initializers/doorkeeper.rb]
Doorkeeper.configure do
    access_token_methods :from_bearer_authorization
end
```

## Install
```
$ bundle install  
$ rails db:migrate  
```

## Test
```
$ rails spec
```

## Import OneRoster data from CSV files

1. copy the zip file or csv files in the CSV_FILE_PATH. Sample oneroster.zip files exist in [storage/sample_csv/].

2. execute importing csv files to the database.

- execute now
```
$ rails console  
> CsvImportJob.perform_now
```
- using cron jobs

1. write schedule in [config/schedule.rb].  
(example) "everyday at 4:33 am"
```
every 1.day, at: ['4:33 am'] do
  runner 'CsvImportJob.perform_now'
end
```
2. set cron job.
```
$ bundle exec whenever -i
$ crontab -l
```  
(*) bin/rails requires execute permissions.

## Start RosterHub server
```
$ rails s
```

## Get data with API

1. Register your app with uid and secret.  
'uid' and 'secret' are important.  
```
> app = Doorkeeper::Application.new name: 'applicationname',redirect_uri: 'http://xxxxx/', uid: '[uid]',secret: '[secret]'
> app.save  
```
To allow only specific ip address, add permit_ips.
```
> app = Doorkeeper::Application.new name: 'applicationname',redirect_uri: 'http://xxxxx/', uid: '[uid]',secret: '[secret]', permit_ips: 'ip1,ip2,...'
```
- permit_ips : Forward matching.
*e.g.* ['127.0.0.1', '192.168.']

2. Request access token with uid and secret.  
```
$  curl -i http[s]://[servername][:port]/oauth/token -F grant_type="client_credentials" -F scope="[scope]" -F client_id="[uid]" -F client_secret="[secret]"  
{"access_token":"[accesstoken]","token_type":"bearer","expires_in":nil,"created_at":1510711311}
```
- scope : See config/initializers/doorkeeper.rb. If the scope value is not specified, the value of "default_scopes" will be applied.

3. Call API with access token.  
```
$ curl -H "Authorization: Bearer [accesstoken]" -i http[s]://[servername][:port]/ims/oneroster/v1p1/[endpoint]?[parameters]
```

For some resources, original endpoints with POST/PUT/DELETE methods are experimentally implemented.
```
$ curl -H "Authorization: Bearer [accesstoken]" -H "Content-Type:application/json" -i http[s]://[servername][:port]/ims/oneroster/v1p1/[endpoint] -X POST -d '{"[resourcename]": {...}}'
```

## OneRoster 1.1 endpoints
### Already implemented to RosterHub
| Endpoint | HTTP Verb | Action |
| --- | --- | --- |
| /academicSessions | GET | Return collection of all academic sessions. |
| /academicSessions/{id} | GET | Return specific academic session. |
| /classes | GET | Return collection of classes. |
| /classes/{id} | GET | Return specific class. |
| /courses | GET | Return collection of courses. |
| /courses/{id} | GET | Return specific course. |
| /enrollments | GET | Return collection of all enrollments. |
| /enrollments/{id} | GET | Return specific enrollment. |
| /orgs | GET | Return collection of orgs. |
| /orgs/{id} | GET | Return specific org. |
| /schools | GET | Return collection of schools. A school is an instance of an org. |
| /schools/{id} | GET | Return specific school. A school is an instance of an org. |
| /students | GET | Return collection of students. A student is an instance of a user. |
| /students/{id} | GET | Return specific student. A student is an instance of a user. |
| /teachers | GET | Return collection of teachers. A teacher is an instance of a user. |
| /teachers/{id} | GET | Return specific teacher. |
| /terms | GET | Return collection of terms. A term is an instance of an academic session. |
| /terms/{id} | GET | Return specific term. |
| /users | GET | Return collection of users |
| /users/{id} | GET | Return specific user |
| /schools/{id}/courses | GET | Return the collection of courses taught by this school. |
| /schools/{school_id}/classes/{class_id}/enrollments | GET | Return the collection of all enrollments into this class. |
| /schools/{school_id}/classes/{class_id}/students | GET | Return the collection of students taking this class in this school. |
| /schools/{school_id}/classes/{class_id}/teachers | GET | Return the collection of teachers taking this class in this school. |
| /schools/{school_id}/enrollments | GET | Return the collection of all enrollments for this school. |
| /schools/{school_id}/students | GET | Return the collection of students attending this school. |
| /schools/{school_id}/teachers | GET | Return the collection of teachers teaching at this school. |
| /schools/{school_id}/terms | GET | Return the collection of terms that are used by this school. |
| /terms/{term_id}/classes | GET | Return the collection of classes that are taught in this term. |
| /courses/{course_id}/classes | GET | Return the collection of classes that are teaching this course. |
| /students/{student_id}/classes | GET | Return the collection of classes that this student is taking. |
| /teachers/{teacher_id}/classes | GET | Return the collection of classes that this teacher is teaching. |
| /schools/{school_id}/classes | GET | Return the collection of classes taught by this school. |
| /users/{user_id}/classes | GET | Return the collection of classes attended by this user. |
| /classes/{class_id}/students | GET | Return the collection of students that are taking this class. |
| /classes/{class_id}/teachers | GET | Return the collection of teachers that are teaching this class. |

### Not yet implemented to RosterHub
| Endpoint | HTTP Verb | Action |
| --- | --- | --- |
| /gradingPeriods | GET | Return collection of grading periods. A grading period is an instance of an academic session. |
| /gradingPeriods/{id} | GET | Return specific grading period. A grading period is an instance of an academic session. |
| /demographics | GET | Return collection of demographics. |
| /demographics/{id} | GET | Return specific demographics. |
| /terms/{term_id}/gradingPeriods | GET | Return the collection of Grading Periods that are part of this term. |

## RosterHub original endpoints (Experimental)
| Endpoint | HTTP Verb | Action |
| --- | --- | --- |
| /academicSessions/ | POST | Create a new academic session. |
| /academicSessions/{id} | PUT | Replace specific academic session. |
| /academicSessions/{id} | DELETE | Delete specific academic session. |
| /classes/ | POST | Create a new class. |
| /classes/{id} | PUT | Replace specific class. |
| /classes/{id} | DELETE | Delete specific class. |
| /courses/ | POST | Create a new course. |
| /courses/{id} | PUT | Replace specific course. |
| /courses/{id} | DELETE | Delete specific course. |
| /enrollments/ | POST | Create a new enrollment. |
| /enrollments/{id} | PUT | Replace specific enrollment. |
| /enrollments/{id} | DELETE | Delete specific enrollment. |
| /orgs/ | POST | Create a new org. |
| /orgs/{id} | PUT | Replace specific org. |
| /orgs/{id} | DELETE | Delete specific org. |

## Parameters
### Pagination
 + limit : the number of result to return : The default value for limit is 100.
 + offset : the index of the first record to return.(zero indexed) : The default value for offset is 0.  

 (ex.) http[s]://[domain]/ims/oneroster/v1p1/students?limit=10&offset=10
### Sorting
 + sort=[data_field]
 + orderBy=[asc|desc]  

 (ex.) http[s]://[domain]/ims/oneroster/v1p1/students?sort=familyName&orderBy=asc
### Filtering
 + filter=[data_field][predicate][value] or [data_field][predicate][value][logical][data_field][predicate][value]  

 Filter queries MUST be URL encoded.  
 (ex.) http[s]://[domain]/ims/oneroster/v1p1/students?filter=familyName%3D%27jones%27

## API document in OpenAPI v2 format
 + To get API document in JSON format, start RosterHub server and access to the following URL.
```
http[s]://[servername][:port]/api-docs
```

## Remarks
+ Only bulk data is supported (delta data is NOT supported)

+ NOT supported resources: Demographic Data, Line Items, Line Item Categories, Resources, Results

+ Academic Session
  * NOT supported fields: parent, children
+ Class ('Rclass' is used as 'Class' in RosterHub code)
  * NOT supported fields: location, grades, subjects, subjectCodes, periods, resources
  * Only one value is supported: terms
+ Course
  * NOT supported fields: schoolYear, courseCode, grades, subjects, subjectCodes, resources
+ Enrollment
  * NOT supported fields: status, beginDate, endDate
+ Org
  * NOT supported fields: status, identifier, parent, children
+ User
  * NOT supported fields: status, userIds, middleName, identifier, sms, phone, agents, grades, password
  * Only one value is supported: orgs

### Database dependency
 + One of MySQL/MariaDB, PostgreSQL (9.5+), and SQLite (3.24.0+) is needed to bulk update data.
 + MySQL/MariaDB is the default DB and code for it is well maintained than others.

## References
 + IMS OneRoster: Specification, https://www.imsglobal.org/oneroster-v11-final-specification
 + IMS OneRoster: CSV Tables, https://www.imsglobal.org/oneroster-v11-final-csv-tables
