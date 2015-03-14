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

ActiveRecord::Schema.define(version: 20150314153953) do

  create_table "billing_plans", force: :cascade do |t|
    t.string   "name",         limit: 255,                 null: false
    t.integer  "users",        limit: 4,   default: 0,     null: false
    t.integer  "tasks",        limit: 4
    t.integer  "monthly_cost", limit: 4
    t.integer  "yearly_cost",  limit: 4
    t.boolean  "active",       limit: 1,   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured",     limit: 1,   default: false, null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",            limit: 255, null: false
    t.string   "domain",          limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "slug",            limit: 255, null: false
    t.integer  "billing_plan_id", limit: 4
    t.string   "billing_url",     limit: 255
  end

  add_index "companies", ["domain"], name: "index_companies_on_domain", unique: true, using: :btree
  add_index "companies", ["name"], name: "index_companies_on_name", unique: true, using: :btree

  create_table "funding_instruments", force: :cascade do |t|
    t.string   "token",            limit: 255
    t.integer  "company_id",       limit: 4
    t.string   "type",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",             limit: 255
    t.string   "account_type",     limit: 255
    t.string   "description",      limit: 255
    t.string   "number",           limit: 255
    t.string   "expiration_month", limit: 255
    t.string   "expiration_year",  limit: 255
    t.boolean  "primary",          limit: 1,   default: false, null: false
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,                 null: false
    t.integer  "task_id",    limit: 4,                 null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "accepted",   limit: 1, default: false, null: false
    t.boolean  "approved",   limit: 1, default: false, null: false
    t.boolean  "completed",  limit: 1, default: false, null: false
  end

  add_index "offers", ["user_id", "task_id"], name: "index_offers_on_user_id_and_task_id", unique: true, using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer "company_id",            limit: 4,                   null: false
    t.integer "funding_instrument_id", limit: 4,                   null: false
    t.integer "amount_in_cents",       limit: 4,                   null: false
    t.boolean "processed",             limit: 1,   default: false, null: false
    t.integer "billing_plan_id",       limit: 4,                   null: false
    t.string  "order_url",             limit: 255
    t.string  "debit_url",             limit: 255
  end

  create_table "scheduled_payments", force: :cascade do |t|
    t.integer  "company_id",          limit: 4,                                null: false
    t.integer  "old_billing_plan_id", limit: 4,                                null: false
    t.integer  "new_billing_plan_id", limit: 4,                                null: false
    t.decimal  "amount",                        precision: 10,                 null: false
    t.boolean  "completed",           limit: 1,                default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "title",       limit: 255,                 null: false
    t.string   "description", limit: 255,                 null: false
    t.integer  "difficulty",  limit: 4,                   null: false
    t.integer  "fun_factor",  limit: 4,                   null: false
    t.integer  "size",        limit: 4,                   null: false
    t.string   "category",    limit: 255,                 null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "closed",      limit: 1,   default: false, null: false
    t.integer  "company_id",  limit: 4,                   null: false
    t.string   "user_id",     limit: 255,                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",         null: false
    t.string   "encrypted_password",     limit: 255, default: "",         null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "first_name",             limit: 255
    t.integer  "points",                 limit: 4,   default: 0,          null: false
    t.integer  "company_id",             limit: 4,                        null: false
    t.string   "last_name",              limit: 255
    t.string   "title",                  limit: 255
    t.string   "role",                   limit: 255, default: "Employee", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "verifications", force: :cascade do |t|
    t.integer  "bank_account_id",    limit: 4
    t.string   "status",             limit: 255
    t.string   "href",               limit: 255
    t.integer  "attempts_remaining", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
