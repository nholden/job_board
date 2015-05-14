# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150514112434) do

  create_table "applications", force: true do |t|
    t.integer  "user_id"
    t.integer  "job_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "applications", ["job_id"], name: "index_applications_on_job_id"
  add_index "applications", ["user_id"], name: "index_applications_on_user_id"

  create_table "experiences", force: true do |t|
    t.text     "label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "jobs", force: true do |t|
    t.text     "title"
    t.text     "location"
    t.text     "majors"
    t.text     "description"
    t.text     "instructions"
    t.date     "deadline"
    t.text     "salary"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "experience_id"
    t.integer  "term_id"
  end

  add_index "jobs", ["experience_id"], name: "index_jobs_on_experience_id"
  add_index "jobs", ["term_id"], name: "index_jobs_on_term_id"
  add_index "jobs", ["user_id", "created_at"], name: "index_jobs_on_user_id_and_created_at"
  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id"

  create_table "roles", force: true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", force: true do |t|
    t.text     "label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.text     "description"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.string   "resume_file_name"
    t.string   "resume_content_type"
    t.integer  "resume_file_size"
    t.datetime "resume_updated_at"
  end

  add_index "users", ["role_id"], name: "index_users_on_role_id"

end
