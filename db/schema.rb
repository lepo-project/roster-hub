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

ActiveRecord::Schema.define(version: 20171115010945) do

  create_table "academic_sessions", force: :cascade do |t|
    t.string "sourcedId"
    t.string "status"
    t.text "metadata"
    t.string "title"
    t.date "startDate"
    t.date "endDate"
    t.string "type"
    t.integer "schoolYear"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "sourcedId"
    t.string "status"
    t.text "metadata"
    t.string "title"
    t.string "courseCode"
    t.string "orgSourcedId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.string "sourcedId"
    t.string "status"
    t.text "metadata"
    t.string "classSourcedId"
    t.string "schoolSourcedId"
    t.string "userSourcedId"
    t.string "role"
    t.boolean "primary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "orgs", force: :cascade do |t|
    t.string "sourcedId"
    t.string "status"
    t.text "metadata"
    t.string "name"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rclasses", force: :cascade do |t|
    t.string "sourcedId"
    t.string "status"
    t.text "metadata"
    t.string "title"
    t.string "courseSourcedId"
    t.string "classCode"
    t.string "classType"
    t.string "schoolSourcedId"
    t.string "termSourcedIds"
    t.string "periods"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "sourcedId"
    t.string "status"
    t.text "metadata"
    t.boolean "enabledUser"
    t.string "orgSourcedIds"
    t.string "role"
    t.string "username"
    t.string "givenName"
    t.string "familyName"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end