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

ActiveRecord::Schema[7.0].define(version: 2022_12_20_162409) do
  create_table "deathmatch_votes", force: :cascade do |t|
    t.integer "deathmatch_id", null: false
    t.integer "submission_id", null: false
    t.integer "vote", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deathmatch_id"], name: "index_deathmatch_votes_on_deathmatch_id"
    t.index ["submission_id"], name: "index_deathmatch_votes_on_submission_id"
  end

  create_table "deathmatches", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_deathmatches_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "guid", null: false
    t.string "ip_address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guid"], name: "index_sessions_on_guid"
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "gpt_prompt", null: false
    t.string "gpt_response", null: false
    t.string "gpt_model", null: false
    t.json "response_raw", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_submissions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email_address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address"
  end

end
