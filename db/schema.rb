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

ActiveRecord::Schema.define(version: 2019_02_13_012727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendar_events", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.string "description"
    t.string "event_type"
    t.string "event_id"
    t.string "html_link"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "event_id", "event_type"], name: "index_calendar_events_on_user_id_and_event_id_and_event_type", unique: true
    t.index ["user_id"], name: "index_calendar_events_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.integer "user_id"
    t.string "role_category_id"
    t.string "term"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.date "goal_date"
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.integer "item_id"
    t.string "item_type"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "content_type"
    t.string "base64"
  end

  create_table "learning_types", force: :cascade do |t|
    t.string "label"
    t.integer "user_id"
    t.string "item_type"
    t.integer "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "life_events", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.string "description"
    t.date "from_date"
    t.date "to_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "prototype", default: false
    t.boolean "show_in_annual_view", default: false
  end

  create_table "notes", force: :cascade do |t|
    t.integer "user_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "note_type"
    t.index ["title"], name: "index_notes_on_title"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.string "quote_type"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "role_categories", primary_key: "label", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon_class"
  end

  create_table "roles", primary_key: "label", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.integer "user_id"
    t.integer "item_id"
    t.string "tag_type"
    t.string "item_type"
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "item_type"], name: "index_tags_on_user_id_and_item_type"
    t.index ["user_id", "label"], name: "index_tags_on_user_id_and_label"
    t.index ["user_id", "tag_type"], name: "index_tags_on_user_id_and_tag_type"
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "user_role_categories", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "role_category_id", null: false
    t.integer "importance", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "role_category_id"], name: "index_user_role_categories_on_user_id_and_role_category_id", unique: true
    t.index ["user_id"], name: "index_user_role_categories_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "role_id", null: false
    t.string "tense"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id", "user_id"], name: "index_user_roles_on_role_id_and_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "country"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "sex"
    t.string "marital_status"
    t.string "education"
    t.string "diet"
    t.float "commute_hours"
    t.float "exercise_hours"
    t.float "weekly_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "onboarded_at"
    t.date "date_of_birth"
    t.float "sleep_hours"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "views", force: :cascade do |t|
    t.integer "user_id"
    t.string "item_type"
    t.integer "item_id"
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "web_links", force: :cascade do |t|
    t.integer "user_id"
    t.integer "item_id"
    t.string "item_type"
    t.string "url"
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
