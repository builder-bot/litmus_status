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

ActiveRecord::Schema.define(version: 20150304205254) do

  create_table "servers", force: true do |t|
    t.string   "domain",                      null: false
    t.string   "server_type", default: "web", null: false
    t.integer  "status",      default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "status_messages", force: true do |t|
    t.text     "body",       null: false
    t.integer  "server_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "status_messages", ["server_id"], name: "index_status_messages_on_server_id"

end
