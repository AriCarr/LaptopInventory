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

ActiveRecord::Schema.define(version: 20170530175050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "computers", force: :cascade do |t|
    t.string   "name"
    t.integer  "status",         default: 0
    t.boolean  "history",        default: false
    t.integer  "manufacturer",   default: 0
    t.string   "model"
    t.string   "serial"
    t.string   "product"
    t.float    "space"
    t.float    "processor"
    t.float    "ram"
    t.integer  "computer_id"
    t.integer  "user_id"
    t.text     "comments"
    t.string   "comment_author"
    t.string   "wired_mac"
    t.string   "wireless_mac"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "is_admin",   default: false
    t.boolean  "active",     default: false
    t.boolean  "can_edit",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["name", "email"], name: "index_users_on_name_and_email", unique: true, using: :btree
    t.index ["name"], name: "index_users_on_name", using: :btree
  end

end
