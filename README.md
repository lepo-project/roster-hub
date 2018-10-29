# OneRoster1.1 CSV import and API  
*Under development*

# Out of the application range
+ Demographic Data
+ Line Items
+ Line Item Categories
+ Resources
+ Results

# Some limitations
+ This program supports only bulk data.

+ Academic Session
  * metadata: not supported.
  * parent: not supported.
  * children: not supported.
+ Class
   * We use this object as 'Rclass'.
   * metadata: not supported.
   * location: not supported.
   * grades: not supported.
   * subjects: not supported.
   * terms: only one term.
   * subjectCodes: not supported.
   * periods: not supported.
   *resources: not supported.
+ Course
   * metadata: not supported.
   * schoolYear: not supported.
   * courseCode: not supported.
   * grades: not supported.
   * subjects: not supported.
   * subjectCodes: not supported.
   * resources: not supported.
+ Enrollment
   * status: not supported.
   * metadata: not supported.
   * beginDate: not supported.
   * endDate: not supported.
+ Org
   * status: not supported.
   * metadata: not supported.
   * identifier: not supported.
   * parent: not supported.
   * children: not supported.
+ User
   * status: not supported.
   * metadata: not supported.
   * userIds: not supported.
   * middleName: not supported.
   * identifier: not supported.
   * sms: not supported.
   * phone: not supported.
   * agents: not supported.
   * grades: not supported.
   * password: not supported.

# Setting
```
[config/initializers/constants.rb]  
    CSV_FILE_PATH=':rails_root/public/csv'
    CSV_FILE_PATH = 'public/csv'
    CSV_ZIP_FILE = 'csv.zip'
    BACKUP_DIR = 'backup'
    ROSTER_FILES = ['academicSessions','categories','classes','classResources','courses','courseResources','demographics','enrollments','lineItems','orgs','resources','results','users']
    ZIP_MODE = true
    LIMIT = 100
    OFFSET = 0
    CSV_IMPORT_LOG = 'public/csv/CsvImport.log'
    PERMIT_ADDRESSES = []
```
- PERMIT_ADDRESSES: Forward matching.
*e.g.* ['127.0.0.1', '192.168.']

- To disable Basic authorization for access tokens,
you will need to configure doorkeeper's access_token_methods.

~~:from_access_token_param, :from_bearer_param~~
```
[config/initializers/doorkeeper.rb]
Doorkeeper.configure do
    access_token_methods :from_bearer_authorization
end
```

# Install
```
$ bundle install  
$ rails db:migrate  
```

# Test
```
$ rails spec
```

# Start the server.
```
$ rails s
```

# CSV Import

1. copy the zip file or csv files in the CSV_FILE_PATH  
  A sample csv.zip file exists.

2. execute importing csv files to the database.
(execute now)  
```
$ rails console  
> CsvImportJob.perform_now
```
(using cron jobs)  

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

# Get data with API

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

2. Request access token with uid and secret.  
```
$  curl -i http[s]://[servername][:port]/oauth/token -F grant_type="client_credentials" -F client_id="[uid]" -F client_secret="[secret]"  
{"access_token":"[accesstoken]","token_type":"bearer","expires_in":nil,"created_at":1510711311}
```

3. Call API with access token.  
```
$ curl -H "Authorization: Bearer [accesstoken]" -i http[s]://[servername][:port]/ims/oneroster/v1p1/[endpoint]?[parameters]
```

For some resources, original endpoints with POST/PUT/DELETE methods are experimentally implemented.
```
$ curl -H "Authorization: Bearer [accesstoken]" -H "Content-Type:application/json" -i http[s]://[servername][:port]/ims/oneroster/v1p1/[endpoint] -X POST -d '{"[resourcename]": {...}}'
```



## Endpoints: OneRoster for rostering
### Implemented
| Service Call | Endpoint | HTTP Verb | Action |
| --- | --- | --- | --- |
| getAllAcademicSessions | /academicSessions | GET | Return collection of all academic sessions. |
| getAcademicSession | /academicSessions/{id} | GET | Return specific Academic Session. |
| getAllClasses | /classes | GET | Return collection of classes. |
| getClass | /classes/{id} | GET | Return specific class. |
| getAllCourses | /courses | GET | Return collection of courses. |
| getCourse | /courses/{id} | GET | Return specific course. |
| getAllEnrollments | /enrollments | GET | Return collection of all enrollments. |
| getEnrollment | /enrollments/{id} | GET | Return specific enrollment. |
| getAllOrgs | /orgs | GET | Return collection of Orgs. |
| getOrg | /orgs/{id} | GET | Return Specific Org. |
| getAllSchools | /schools | GET | Return collection of schools. A School is an instance of an Org. |
| getSchool | /schools/{id} | GET | Return specific school. A School is an instance of an Org. |
| getAllStudents | /students | GET | Return collection of students. A Student is an instance of a User. |
| getStudent | /students/{id} | GET | Return specific student. A Student is an instance of a User. |
| getAllTeachers | /teachers | GET | Return collection of teachers. A Teacher is an instance of a User. |
| getTeacher | /teachers/{id} | GET | Return specific teacher. |
| getAllTerms | /terms | GET | Return collection of terms. A Term is an instance of an AcademicSession. |
| getTerm | /terms/{id} | GET | Return specific term. |
| getAllUsers | /users | GET | Return collection of users |
| getUser | /users/{id} | GET | Return specific user |
| getCoursesForSchool | /schools/{id}/courses | GET | Return the collection of courses taught by this school. |
| getClassesForTerm | /terms/{term_id}/classes | GET | Return the collection of classes that are taught in this term. |
| getStudentsForClass | /classes/{class_id}/students | GET | Return the collection of students that are taking this class. |
| getTeachersForClass | /classes/{class_id}/teachers | GET | Return the collection of teachers that are teaching this class. |

### Not yet implemented
| Service Call | Endpoint | HTTP Verb | Action |
| --- | --- | --- | --- |
| getAllGradingPeriods | /gradingPeriods | GET | Return collection of grading periods. A Grading Period is an instance of an AcademicSession. |
| getGradingPeriod | /gradingPeriods/{id} | GET | Return specific Grading Period. A Grading Period is an instance of an AcademicSession. |
| getAllDemographics | /demographics | GET | Return collection of demographics. |
| getDemographics | /demographics/{id} | GET | Return specific demographics. |
| getEnrollmentsForClassInSchool | /schools/{school_id}/classes/{class_id}/enrollments | GET | Return the collection of all enrollments into this class. |
| getStudentsForClassInSchool | /schools/{school_id}/classes/{class_id}/students | GET | Return the collection of students taking this class in this school. |
| getTeachersForClassInSchool | /schools/{school_id}/classes/{class_id}/teachers | GET | Return the collection of teachers taking this class in this school. |
| getEnrollmentsForSchool | /schools/{school_id}/enrollments | GET | Return the collection of all enrollments for this school. |
| getStudentsForSchool | /schools/{school_id}/students | GET | Return the collection of students attending this school. |
| getTeachersForSchool | /schools/{school_id}/teachers | GET | Return the collection of teachers teaching at this school. |
| getTermsForSchool | /schools/{school_id}/terms | GET | Return the collection of terms that are used by this school. |
| getGradingPeriodsForTerm | /terms/{term_id}/gradingPeriods | GET | Return the collection of Grading Periods that are part of this term. |
| getClassesForCourse | /courses/{course_id}/classes | GET | Return the collection of classes that are teaching this course. |
| getClassesForStudent | /students/{student_id}/classes | GET | Return the collection of classes that this student is taking. |
| getClassesForTeacher | /teachers/{teacher_id}/classes | GET | Return the collection of classes that this teacher is teaching. |
| getClassesForSchool | /schools/{school_id}/classes | GET | Return the collection of classes taught by this school. |
| getClassesForUser | /users/{user_id}/classes | GET | Return the collection of classes attended by this user. |

## Endpoints: Original
 | Service Call | Endpoint | HTTP Verb | Action |
 | --- | --- | --- | --- |
 | postClass | /classes/ | POST | To create a new Class record. |
 | putClass | /classes/{id} | PUT | To replace one that already exists. |
 | deleteClass | /classes/{id} | DELETE | To delete one that already exists. |
 | postCourse | /courses/ | POST | To create a new Course record. |
 | putCourse | /courses/{id} | PUT | To replace one that already exists. |
 | deleteCourse | /courses/{id} | DELETE | To delete one that already exists. |
 | postEnrollment | /enrollments/ | POST | To create a new Enrollment record. |
 | putEnrollment | /enrollments/{id} | PUT | To replace one that already exists. |
 | deleteEnrollment | /enrollments/{id} | DELETE | To delete one that already exists. |

## Pagination
 + limit : the number of result to return : The default value for limit is 100.
 + offset : the index of the first record to return.(zero indexed) : The default value for offset is 0.  

 (ex.)http[s]://[domain]/ims/oneroster/v1p1/students?limit=10&offset=10
## Sorting
 + sort=[data_field]
 + orderBy=[asc|desc]  

 (ex.)http[s]://[domain]/ims/oneroster/v1p1/students?sort=familyName&orderBy=asc
## Filtering
 + filter=[data_field][predicate][value] or [data_field][predicate][value][logical][data_field][predicate][value]  

 Filter queries MUST be URL encoded.  
 (ex.) http[s]://[domain]/ims/oneroster/v1p1/filter=familyName%3D%27jones%27

## OpenAPI
```
http[s]://[servername][:port]/api-docs
```

## Database dependency
 + One of MySQL, PostgreSQL (9.5+), and SQLite (3.24.0+) is needed to bulk update data.
 + Default DB is MySQL (No code changes are needed)
 + To use PostgreSQL or SQLite, some modifications are needed for "on_duplicate_key_update"
