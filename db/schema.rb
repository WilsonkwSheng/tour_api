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

ActiveRecord::Schema[7.0].define(version: 2024_03_29_064349) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "images", force: :cascade do |t|
    t.string "imageable_type", null: false
    t.bigint "imageable_id", null: false
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable"
  end

  create_table "itineraries", force: :cascade do |t|
    t.bigint "tour_id", null: false
    t.date "date", null: false
    t.integer "day", null: false
    t.time "start_at", null: false
    t.time "end_at", null: false
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tour_id", "date", "start_at", "end_at"], name: "index_itineraries_on_tour_id_and_date_and_start_at_and_end_at", unique: true
    t.index ["tour_id"], name: "index_itineraries_on_tour_id"
  end

  create_table "tour_hosts", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_tour_hosts_on_email", unique: true
  end

  create_table "tours", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.string "region", null: false
    t.string "city", null: false
    t.string "travel_type", null: false
    t.bigint "tour_host_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tour_host_id"], name: "index_tours_on_tour_host_id"
  end

  add_foreign_key "itineraries", "tours"
  add_foreign_key "tours", "tour_hosts"
end
