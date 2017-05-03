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

ActiveRecord::Schema.define(version: 20170503022059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "developers", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "name"
    t.string   "medium_username",  default: ""
    t.string   "twitter_username", default: ""
  end

  create_table "github_users", force: :cascade do |t|
    t.string   "login"
    t.integer  "user_id"
    t.string   "name",               default: ""
    t.string   "company",            default: ""
    t.string   "blog",               default: ""
    t.string   "location",           default: ""
    t.string   "email",              default: ""
    t.boolean  "hireable",           default: false
    t.string   "bio",                default: ""
    t.integer  "public_repos",       default: 0
    t.integer  "public_gists",       default: 0
    t.integer  "followers",          default: 0
    t.integer  "following",          default: 0
    t.integer  "contributions",      default: [],                 array: true
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "developer_id"
    t.string   "prefered_languages", default: [],                 array: true
    t.index ["developer_id"], name: "index_github_users_on_developer_id", using: :btree
  end

  create_table "memberships", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "developer_id"
    t.integer  "team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
    t.boolean  "is_public",  default: false
    t.index ["user_id"], name: "index_teams_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.boolean  "email_confirmed", default: false
    t.string   "confirm_token"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "github_users", "developers"
  add_foreign_key "teams", "users"
end
