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

ActiveRecord::Schema.define(version: 2019_02_27_000830) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "current_weathers", force: :cascade do |t|
    t.float "temperature"
    t.float "temp_feels_like"
    t.float "temp_high"
    t.float "temp_low"
    t.float "humidity"
    t.float "visibility"
    t.float "uv_index"
    t.string "summary"
    t.string "summary_short"
    t.string "summary_tonight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "location_id"
    t.index ["location_id"], name: "index_favorites_on_location_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "city"
    t.string "state"
    t.string "latitude"
    t.string "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "current_weather_id"
    t.index ["current_weather_id"], name: "index_locations_on_current_weather_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_key"
  end

  create_table "weather_days_collections", force: :cascade do |t|
    t.jsonb "weather_days_data"
  end

  create_table "weather_hours_collections", force: :cascade do |t|
    t.jsonb "weather_hours_data"
  end

  add_foreign_key "favorites", "locations"
  add_foreign_key "favorites", "users"
  add_foreign_key "locations", "current_weathers"
end
