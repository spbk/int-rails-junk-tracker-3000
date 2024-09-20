# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_09_20_184339) do

  create_table "advertisements", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "vehicle_id", null: false
    t.text "display"
    t.index ["vehicle_id"], name: "index_advertisements_on_vehicle_id"
  end

  create_table "doors", force: :cascade do |t|
    t.integer "vehicle_id", null: false
    t.boolean "sliding", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vehicle_id"], name: "index_doors_on_vehicle_id"
  end

  create_table "engines", force: :cascade do |t|
    t.integer "vehicle_id", null: false
    t.string "status", default: "works", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vehicle_id"], name: "index_engines_on_vehicle_id"
  end

  create_table "seats", force: :cascade do |t|
    t.integer "vehicle_id", null: false
    t.string "status", default: "works", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vehicle_id"], name: "index_seats_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "nickname"
    t.string "registration_id"
    t.integer "mileage", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
  end

  add_foreign_key "advertisements", "vehicles"
  add_foreign_key "doors", "vehicles"
  add_foreign_key "engines", "vehicles"
  add_foreign_key "seats", "vehicles"
end
