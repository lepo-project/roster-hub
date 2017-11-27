# OneRoster1.1 CSV import and API  
*Under development*

# Setting
```
[config/initializers/constants.rb]  
    CSV_FILE_PATH=':rails_root/public/csv'
```

# Install
```
$ bundle install  
$ rails db:migrate  
```

# Start the server.
```
$ rails s
```

# CSV Import

1. copy the csv fiels in the CSV_FILE_PATH  

2. execute importing csv files to the database.
(execute now)  
```
$ rails console  
> CsvImportJob.perform_now
```
(using cron jobs)  

1. write schedule in [config/schedule.rb].  
(example) "everday at 4:33 am"
```
every 1.day, :at => '4:33 am' do
  runner 'CsvImportJob.perform_now'
end
```
2. set cron job.
```
$ bundle exec whenever -i
$ crontab -l
```
# Get data with API

1. Register your app with uid and secret.  
'uid' and 'secret' are important.  
```
> app = Doorkeeper::Application.new :name=>'applicationname',:redirect_uri=>'http://xxxxx/', :uid=>'[uid]',:secret=>'[secret]'  
> app.save  
```
2. Request access token with uid and secret.  
```
$  curl -i http[s]://[servername][:port]/oauth/token -F grant_type="client_credentials" -F client_id="[uid]" -F client_secret="[secret]"  
{"access_token":"[accesstoken]","token_type":"bearer","expires_in":nil,"created_at":1510711311}
```

3. Call API with access token.  
```
$ curl -i http[s]://[servername][:port]/ims/oneroster/v1p1/[endpoint]?[parameters&]access_token=[accesstoken]
```


# Endpoint
| Service Call | Endpoint | HTTP Verb | Action | Impl. |
| --- | --- | --- | --- | --- |
| getAllAcademicSessions | /academicSessions | GET | Return collection of all academic sessions. | OK | 
 | getAcademicSession | /academicSessions/{id} | GET | Return specific Academic Session. | OK | 
 | getAllClasses | /classes | GET | Return collection of classes. | OK | 
 | getClass | /classes/{id} | GET | Return specific class. | OK | 
 | getAllCourses | /courses | GET | Return collection of courses. | OK | 
 | getCourse | /courses/{id} | GET | Return specific course. | OK | 
 | getAllGradingPeriods | /gradingPeriods | GET | Return collection of grading periods. A Grading Period is an instance of an AcademicSession. |  | 
 | getGradingPeriod | /gradingPeriods/{id} | GET | Return specific Grading Period. A Grading Period is an instance of an AcademicSession. |  | 
 | getAllDemographics | /demographics | GET | Return collection of demographics. |  | 
 | getDemographics | /demographics/{id} | GET | Return specific demographics. |  | 
 | getAllEnrollments | /enrollments | GET | Return collection of all enrollments. | OK | 
 | getEnrollment | /enrollments/{id} | GET | Return specific enrollment. | OK | 
 | getAllOrgs | /orgs | GET | Return collection of Orgs. | OK | 
 | getOrg | /orgs/{id} | GET | Return Specific Org. | OK | 
 | getAllSchools | /schools | GET | Return collection of schools. A School is an instance of an Org. | OK | 
 | getSchool | /schools/{id} | GET | Return specific school. A School is an instance of an Org. | OK | 
 | getAllStudents | /students | GET | Return collection of students. A Student is an instance of a User. | OK | 
 | getStudent | /students/{id} | GET | Return specific student. A Student is an instance of a User. | OK | 
 | getAllTeachers | /teachers | GET | Return collection of teachers. A Teacher is an instance of a User. | OK. | 
 | getTeacher | /teachers/{id} | GET | Return specific teacher. | OK | 
 | getAllTerms | /terms | GET | Return collection of terms. A Term is an instance of an AcademicSession. | OK | 
 | getTerm | /terms/{id} | GET | Return specific term. | OK | 
 | getAllUsers | /users | GET | Return collection of users | OK | 
 | getUser | /users/{id} | GET | Return specific user | OK | 
 | getCoursesForSchool | /schools/{id}/courses | GET | Return the collection of courses taught by this school. | OK | 
 | getEnrollmentsForClassInSchool | /schools/{school_id}/classes/{class_id}/enrollments | GET | Return the collection of all enrollments into this class. |  | 
 | getStudentsForClassInSchool | /schools/{school_id}/classes/{class_id}/students | GET | Return the collection of students taking this class in this school. |  | 
 | getTeachersForClassInSchool | /schools/{school_id}/classes/{class_id}/teachers | GET | Return the collection of teachers taking this class in this school. |  | 
 | getEnrollmentsForSchool | /schools/{school_id}/enrollments | GET | Return the collection of all enrollments for this school. |  | 
 | getStudentsForSchool | /schools/{school_id}/students | GET | Return the collection of students attending this school. |  | 
 | getTeachersForSchool | /schools/{school_id}/teachers | GET | Return the collection of teachers teaching at this school. |  | 
 | getTermsForSchool | /schools/{school_id}/terms | GET | Return the collection of terms that are used by this school. |  | 
 | getClassesForTerm | /terms/{term_id}/classes | GET | Return the collection of classes that are taught in this term. |  | 
 | getGradingPeriodsForTerm | /terms/{term_id}/gradingPeriods | GET | Return the collection of Grading Periods that are part of this term. |  | 
 | getClassesForCourse | /courses/{course_id}/classes | GET | Return the collection of classes that are teaching this course. |  | 
 | getClassesForStudent | /students/{student_id}/classes | GET | Return the collection of classes that this student is taking. |  | 
 | getClassesForTeacher | /teachers/{teacher_id}/classes | GET | Return the collection of classes that this teacher is teaching. |  | 
 | getClassesForSchool | /schools/{school_id}/classes | GET | Return the collection of classes taught by this school. |  | 
 | getClassesForUser | /users/{user_id}/classes | GET | Return the collection of classes attended by this user. |  | 
 | getStudentsForClass | /classes/{class_id}/students | GET | Return the collection of students that are taking this class. |  | 
 | getTeachersForClass | /classes/{class_id}/teachers | GET | Return the collection of teachers that are teaching this class. |  | 
 
# Pagination
 + limit : the number of result to return : The default value for limit is 100.
 + offset : the index of the first record to return.(zero indexed) : The default value for offset is 0.  

 (ex.)http[s]://[domain]/ims/oneroster/v1p1/students?limit=10&offset=10
# Sorting
 + sort=[data_field]
 + orderBy=[asc|desc]  

 (ex.)http[s]://[domain]/ims/oneroster/v1p1/students?sort=familyName&orderBy=asc
# Filtering
 + filter=[data_field][predicate][value] or [data_field][predicate][value][logical][data_field][predicate][value]  

 Filter queries MUST be URL encoded.  
 (ex.) http[s]://[domain]/ims/oneroster/v1p1/filter=familyName%3D%27jones%27