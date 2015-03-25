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

ActiveRecord::Schema.define(version: 20150325090559) do

  create_table "reviews", force: :cascade do |t|
    t.integer  "status",      limit: 4,     default: 0
    t.integer  "reviewer_id", limit: 4
    t.integer  "reviewee_id", limit: 4
    t.text     "text",        limit: 65535
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "reviews", ["reviewee_id"], name: "index_reviews_on_reviewee_id", using: :btree
  add_index "reviews", ["reviewer_id"], name: "index_reviews_on_reviewer_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",               limit: 255, default: "", null: false
    t.string   "name",                limit: 255
    t.string   "image",               limit: 255
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",  limit: 255
    t.string   "last_sign_in_ip",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "reviews", "users", column: "reviewee_id"
  add_foreign_key "reviews", "users", column: "reviewer_id"
end
