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

ActiveRecord::Schema.define(version: 20170705162812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "outbound_messages", force: :cascade do |t|
    t.string "destination", limit: 16
    t.text "text_message"
    t.string "sender", limit: 11
    t.string "linkid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "short_codes", force: :cascade do |t|
    t.string "code", limit: 6
    t.boolean "activated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "phone_number", limit: 16
    t.boolean "active"
    t.datetime "first_subscribed_at"
    t.datetime "last_subscribed_at"
    t.datetime "last_unsubscribed_at"
    t.bigint "short_code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["short_code_id"], name: "index_subscribers_on_short_code_id"
  end

  create_table "subscription_notifications", force: :cascade do |t|
    t.string "phone_number", limit: 16
    t.string "short_code", limit: 6
    t.string "notification_type", limit: 15
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscription_welcome_messages", force: :cascade do |t|
    t.text "text_message"
    t.bigint "short_code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["short_code_id"], name: "index_subscription_welcome_messages_on_short_code_id"
  end

  add_foreign_key "subscribers", "short_codes"
  add_foreign_key "subscription_welcome_messages", "short_codes"
end
