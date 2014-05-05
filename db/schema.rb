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

ActiveRecord::Schema.define(version: 20140504220757) do

  create_table "basic_files", force: true do |t|
    t.string   "path",       null: false
    t.integer  "size"
    t.string   "md5"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "basic_files", ["path"], name: "index_basic_files_on_path", unique: true

  create_table "build_files", force: true do |t|
    t.integer  "build_id"
    t.integer  "position"
    t.integer  "rule_set_id"
    t.integer  "input_file_id"
    t.integer  "output_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "build_files", ["build_id"], name: "index_build_files_on_build_id"
  add_index "build_files", ["input_file_id"], name: "index_build_files_on_input_file_id"
  add_index "build_files", ["output_file_id"], name: "index_build_files_on_output_file_id"
  add_index "build_files", ["rule_set_id"], name: "index_build_files_on_rule_set_id"

  create_table "builds", force: true do |t|
    t.string   "name"
    t.integer  "output_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "builds", ["output_file_id"], name: "index_builds_on_output_file_id"

  create_table "field_mappings", force: true do |t|
    t.integer  "rule_set_id"
    t.string   "src_field_name"
    t.string   "out_field_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "field_mappings", ["rule_set_id"], name: "index_field_mappings_on_rule_set_id"

  create_table "rule_sets", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
