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

ActiveRecord::Schema[7.1].define(version: 2025_01_22_222017) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "shows", force: :cascade do |t|
    t.string "artist", null: false
    t.string "location", null: false
    t.integer "time_slot"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_shows", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "show_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["show_id"], name: "index_users_shows_on_show_id"
    t.index ["user_id", "show_id"], name: "index_users_shows_on_user_id_and_show_id", unique: true
    t.index ["user_id"], name: "index_users_shows_on_user_id"
  end

  add_foreign_key "users_shows", "shows"
  add_foreign_key "users_shows", "users"
end
