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

ActiveRecord::Schema.define(version: 20150905122406) do

  create_table "bottoms", force: true do |t|
    t.integer  "outfit_id"
    t.string   "file_name"
    t.integer  "main_category",   default: 0
    t.string   "clothing_type"
    t.string   "clothing_type_2"
    t.string   "pleat"
    t.string   "material"
    t.string   "brand"
    t.string   "pattern"
    t.string   "color_1"
    t.string   "color_2"
    t.boolean  "spring"
    t.boolean  "summer"
    t.boolean  "fall"
    t.boolean  "winter"
    t.boolean  "warm"
    t.boolean  "hot"
    t.boolean  "brisk"
    t.boolean  "cold"
    t.boolean  "casual"
    t.boolean  "going_out"
    t.boolean  "dressy"
    t.boolean  "formal"
    t.boolean  "priority"
    t.boolean  "batch_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outfit_tops", force: true do |t|
    t.integer  "outfit_id"
    t.integer  "top_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "outfit_tops", ["outfit_id", "top_id"], name: "index_outfit_tops_on_outfit_id_and_top_id"

  create_table "outfits", force: true do |t|
    t.integer  "user_id"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tops", force: true do |t|
    t.string   "file_name"
    t.integer  "main_category", default: 0
    t.string   "clothing_type"
    t.string   "collar_type"
    t.string   "material"
    t.string   "brand"
    t.string   "pattern"
    t.string   "color_1"
    t.string   "color_2"
    t.boolean  "spring"
    t.boolean  "summer"
    t.boolean  "fall"
    t.boolean  "winter"
    t.boolean  "warm"
    t.boolean  "hot"
    t.boolean  "brisk"
    t.boolean  "cold"
    t.boolean  "casual"
    t.boolean  "going_out"
    t.boolean  "dressy"
    t.boolean  "formal"
    t.boolean  "first_layer"
    t.boolean  "second_layer"
    t.boolean  "third_layer"
    t.boolean  "fourth_layer"
    t.boolean  "priority"
    t.boolean  "batch_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tops", ["file_name"], name: "index_tops_on_file_name"

  create_table "user_bottoms", force: true do |t|
    t.integer  "user_id"
    t.integer  "bottom_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_bottoms", ["user_id", "bottom_id"], name: "index_user_bottoms_on_user_id_and_bottom_id"

  create_table "user_tops", force: true do |t|
    t.integer  "user_id"
    t.integer  "top_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_tops", ["user_id", "top_id"], name: "index_user_tops_on_user_id_and_top_id"

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "preferences"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
