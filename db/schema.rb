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

ActiveRecord::Schema.define(version: 20160604023331) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blackboxes", force: :cascade do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "blackboxes", ["organization_id"], name: "index_blackboxes_on_organization_id", using: :btree

  create_table "incident_logs", force: :cascade do |t|
    t.string   "action"
    t.integer  "incident_id"
    t.boolean  "is_starred"
    t.boolean  "is_archived"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "incident_logs", ["incident_id"], name: "index_incident_logs_on_incident_id", using: :btree

  create_table "incidents", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "blackbox_id"
    t.boolean  "is_archived"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "reference_id", null: false
  end

  add_index "incidents", ["blackbox_id"], name: "index_incidents_on_blackbox_id", using: :btree

  create_table "organization_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.integer  "user_role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "organization_users", ["organization_id"], name: "index_organization_users_on_organization_id", using: :btree
  add_index "organization_users", ["user_id"], name: "index_organization_users_on_user_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "encrypted_pagerduty_account"
    t.string   "encrypted_pagerduty_account_iv"
    t.string   "encrypted_pagerduty_token"
    t.string   "encrypted_pagerduty_token_iv"
    t.string   "slug"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "pager_duty_webhook_events", force: :cascade do |t|
    t.string   "ip"
    t.jsonb    "body"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "is_processed", default: false, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "full_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "image_url"
    t.string   "google_plus_url"
    t.string   "gender"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_foreign_key "blackboxes", "organizations"
  add_foreign_key "incident_logs", "incidents"
  add_foreign_key "incidents", "blackboxes"
end
