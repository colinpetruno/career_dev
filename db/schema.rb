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

ActiveRecord::Schema.define(version: 20150317001550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billing_plans", force: :cascade do |t|
    t.string   "name",                         null: false
    t.integer  "users",        default: 0,     null: false
    t.integer  "tasks"
    t.integer  "monthly_cost"
    t.integer  "yearly_cost"
    t.boolean  "active",       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured",     default: false, null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",                                  null: false
    t.string   "domain"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "slug",                                  null: false
    t.integer  "billing_plan_id"
    t.string   "stripe_id"
    t.string   "billing_frequency", default: "monthly", null: false
  end

  add_index "companies", ["domain"], name: "index_companies_on_domain", unique: true, using: :btree
  add_index "companies", ["name"], name: "index_companies_on_name", unique: true, using: :btree

  create_table "funding_instruments", force: :cascade do |t|
    t.string   "token"
    t.integer  "company_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "account_type"
    t.string   "description"
    t.string   "number"
    t.string   "expiration_month"
    t.string   "expiration_year"
    t.boolean  "primary",          default: false, null: false
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.integer  "task_id",                    null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "accepted",   default: false, null: false
    t.boolean  "approved",   default: false, null: false
    t.boolean  "completed",  default: false, null: false
  end

  add_index "offers", ["user_id", "task_id"], name: "index_offers_on_user_id_and_task_id", unique: true, using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer "company_id",                            null: false
    t.integer "funding_instrument_id",                 null: false
    t.integer "amount_in_cents",                       null: false
    t.boolean "processed",             default: false, null: false
    t.integer "billing_plan_id",                       null: false
    t.string  "order_url"
    t.string  "debit_url"
  end

  create_table "scheduled_payments", force: :cascade do |t|
    t.integer  "company_id",                          null: false
    t.integer  "old_billing_plan_id",                 null: false
    t.integer  "new_billing_plan_id",                 null: false
    t.decimal  "amount",                              null: false
    t.boolean  "completed",           default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "billing_plan_id",                     null: false
    t.integer  "company_id",                          null: false
    t.string   "stripe_id",                           null: false
    t.string   "frequency",       default: "monthly", null: false
    t.boolean  "active",          default: true,      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title",                       null: false
    t.string   "description",                 null: false
    t.integer  "difficulty",                  null: false
    t.integer  "fun_factor",                  null: false
    t.integer  "size",                        null: false
    t.string   "category",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "closed",      default: false, null: false
    t.integer  "company_id",                  null: false
    t.string   "user_id",                     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",         null: false
    t.string   "encrypted_password",     default: "",         null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.integer  "points",                 default: 0,          null: false
    t.integer  "company_id"
    t.string   "last_name"
    t.string   "title"
    t.string   "role",                   default: "Employee", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "verifications", force: :cascade do |t|
    t.integer  "bank_account_id"
    t.string   "status"
    t.string   "href"
    t.integer  "attempts_remaining"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
