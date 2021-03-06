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

ActiveRecord::Schema.define(version: 20161116043106) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.datetime "schedule_day"
    t.datetime "schdule_time"
    t.integer  "barber_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "summary"
    t.string   "description"
    t.string   "location"
    t.string   "name"
    t.string   "phone"
    t.string   "email"
  end

  create_table "galleries", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "hairstyle_image_id"
  end

  create_table "referrals", force: :cascade do |t|
    t.boolean  "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "barber_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "role"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "unique_code"
    t.string   "gcalendar_id"
    t.boolean  "subscribed"
    t.string   "stripeid"
    t.string   "referral_code"
    t.string   "cronofy_access_token"
    t.string   "cronofy_refresh_token"
    t.integer  "expiration"
    t.datetime "start_time"
    t.datetime "end_time"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
