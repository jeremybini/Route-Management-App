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

ActiveRecord::Schema.define(version: 20150829211901) do

  create_table "climbs", force: :cascade do |t|
    t.string   "climb_type"
    t.string   "color"
    t.integer  "grade",              default: 0
    t.string   "setter_name"
    t.boolean  "active",             default: true
    t.integer  "wall_id"
    t.integer  "gym_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_orientation"
    t.integer  "setter_id"
  end

  add_index "climbs", ["gym_id"], name: "index_climbs_on_gym_id"
  add_index "climbs", ["wall_id"], name: "index_climbs_on_wall_id"

  create_table "gyms", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "gym_image"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_orientation"
  end

  create_table "sends", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "climb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sends", ["climb_id"], name: "index_sends_on_climb_id"
  add_index "sends", ["user_id"], name: "index_sends_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "role",                   default: "User"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "walls", force: :cascade do |t|
    t.string   "name"
    t.string   "wall_image"
    t.string   "wall_type"
    t.integer  "gym_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "wall_spread"
    t.string   "image_orientation"
  end

  add_index "walls", ["gym_id"], name: "index_walls_on_gym_id"

end
