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

ActiveRecord::Schema.define(version: 20150818030223) do

  create_table "climbs", force: :cascade do |t|
    t.string   "climb_type"
    t.string   "color"
    t.integer  "grade"
    t.string   "setter"
    t.boolean  "active",             default: true
    t.integer  "wall_id"
    t.integer  "gym_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
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
  end

  create_table "ideal_boulder_spreads", force: :cascade do |t|
    t.integer  "VB"
    t.integer  "V0"
    t.integer  "V1"
    t.integer  "V2"
    t.integer  "V3"
    t.integer  "V4"
    t.integer  "V5"
    t.integer  "V6"
    t.integer  "V7"
    t.integer  "V8"
    t.integer  "V9"
    t.integer  "V10"
    t.integer  "V11"
    t.integer  "V12"
    t.integer  "V13"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "gym_id"
    t.integer  "wall_id"
  end

  add_index "ideal_boulder_spreads", ["gym_id"], name: "index_ideal_boulder_spreads_on_gym_id"
  add_index "ideal_boulder_spreads", ["wall_id"], name: "index_ideal_boulder_spreads_on_wall_id"

  create_table "ideal_route_spreads", force: :cascade do |t|
    t.integer  "YDS_5"
    t.integer  "YDS_6"
    t.integer  "YDS_7"
    t.integer  "YDS_8"
    t.integer  "YDS_9"
    t.integer  "YDS_10a"
    t.integer  "YDS_10b"
    t.integer  "YDS_10c"
    t.integer  "YDS_10d"
    t.integer  "YDS_11a"
    t.integer  "YDS_11b"
    t.integer  "YDS_11c"
    t.integer  "YDS_11d"
    t.integer  "YDS_12a"
    t.integer  "YDS_12b"
    t.integer  "YDS_12c"
    t.integer  "YDS_12d"
    t.integer  "YDS_13a"
    t.integer  "YDS_13b"
    t.integer  "YDS_13c"
    t.integer  "YDS_13d"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "gym_id"
    t.integer  "wall_id"
  end

  add_index "ideal_route_spreads", ["gym_id"], name: "index_ideal_route_spreads_on_gym_id"
  add_index "ideal_route_spreads", ["wall_id"], name: "index_ideal_route_spreads_on_wall_id"

  create_table "users", force: :cascade do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "role"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "walls", force: :cascade do |t|
    t.string   "name"
    t.string   "wall_image"
    t.string   "wall_type"
    t.text     "ideal_grade_spread"
    t.integer  "gym_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "walls", ["gym_id"], name: "index_walls_on_gym_id"

end
