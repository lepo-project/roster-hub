# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20191101000007) do

  create_table "academic_sessions", primary_key: "sourcedId", id: :string, force: :cascade do |t|
    t.string "status"
    t.datetime "dateLastModified"
    t.string "title"
    t.string "type"
    t.date "startDate"
    t.date "endDate"
    t.string "parentSourcedId"
    t.integer "schoolYear"
    t.text "metadata"
    t.integer "application_id", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_academic_sessions_on_application_id"
    t.index ["sourcedId"], name: "sqlite_autoindex_academic_sessions_1", unique: true
  end

  create_table "courses", primary_key: "sourcedId", id: :string, force: :cascade do |t|
    t.string "status"
    t.datetime "dateLastModified"
    t.string "schoolYearSourcedId"
    t.string "title"
    t.string "courseCode"
    t.string "grades"
    t.string "orgSourcedId"
    t.string "subjects"
    t.string "subjectCodes"
    t.text "metadata"
    t.integer "application_id", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_courses_on_application_id"
    t.index ["orgSourcedId"], name: "index_courses_on_orgSourcedId"
    t.index ["sourcedId"], name: "sqlite_autoindex_courses_1", unique: true
  end

  create_table "enrollments", primary_key: "sourcedId", id: :string, force: :cascade do |t|
    t.string "status"
    t.datetime "dateLastModified"
    t.string "classSourcedId"
    t.string "schoolSourcedId"
    t.string "userSourcedId"
    t.string "role"
    t.boolean "primary"
    t.date "beginDate"
    t.date "endDate"
    t.text "metadata"
    t.integer "application_id", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_enrollments_on_application_id"
    t.index ["classSourcedId"], name: "index_enrollments_on_classSourcedId"
    t.index ["schoolSourcedId"], name: "index_enrollments_on_schoolSourcedId"
    t.index ["sourcedId"], name: "sqlite_autoindex_enrollments_1", unique: true
    t.index ["userSourcedId"], name: "index_enrollments_on_userSourcedId"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.integer "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.string "permit_ips"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "orgs", primary_key: "sourcedId", id: :string, force: :cascade do |t|
    t.string "status"
    t.datetime "dateLastModified"
    t.string "name"
    t.string "type"
    t.string "identifier"
    t.string "parentSourcedId"
    t.text "metadata"
    t.integer "application_id", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_orgs_on_application_id"
    t.index ["sourcedId"], name: "sqlite_autoindex_orgs_1", unique: true
  end

  create_table "rclasses", primary_key: "sourcedId", id: :string, force: :cascade do |t|
    t.string "status"
    t.datetime "dateLastModified"
    t.string "title"
    t.string "grades"
    t.string "courseSourcedId"
    t.string "classCode"
    t.string "classType"
    t.string "location"
    t.string "schoolSourcedId"
    t.string "termSourcedIds"
    t.string "subjects"
    t.string "subjectCodes"
    t.string "periods"
    t.text "metadata"
    t.integer "application_id", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_rclasses_on_application_id"
    t.index ["courseSourcedId"], name: "index_rclasses_on_courseSourcedId"
    t.index ["schoolSourcedId"], name: "index_rclasses_on_schoolSourcedId"
    t.index ["sourcedId"], name: "sqlite_autoindex_rclasses_1", unique: true
    t.index ["termSourcedIds"], name: "index_rclasses_on_termSourcedIds"
  end

  create_table "users", primary_key: "sourcedId", id: :string, force: :cascade do |t|
    t.string "status"
    t.datetime "dateLastModified"
    t.boolean "enabledUser"
    t.string "orgSourcedIds"
    t.string "role"
    t.string "username"
    t.string "userIds"
    t.string "givenName"
    t.string "familyName"
    t.string "middleName"
    t.string "identifier"
    t.string "email"
    t.string "sms"
    t.string "phone"
    t.string "agentSourcedIds"
    t.string "grades"
    t.string "password"
    t.text "metadata"
    t.integer "application_id", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_users_on_application_id"
    t.index ["orgSourcedIds"], name: "index_users_on_orgSourcedIds"
    t.index ["sourcedId"], name: "sqlite_autoindex_users_1", unique: true
  end

end
