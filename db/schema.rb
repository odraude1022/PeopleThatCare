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

ActiveRecord::Schema.define(version: 2019_03_16_015704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "category_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_name"], name: "index_categories_on_category_name", unique: true
  end

  create_table "charities", force: :cascade do |t|
    t.string "organization_name", null: false
    t.integer "tax_id", null: false
    t.string "contact_name", null: false
    t.string "contact_email", null: false
    t.string "twitter_handle"
    t.string "website_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.index ["contact_email"], name: "index_charities_on_contact_email", unique: true
    t.index ["tax_id"], name: "index_charities_on_tax_id", unique: true
    t.index ["twitter_handle"], name: "index_charities_on_twitter_handle", unique: true
    t.index ["website_url"], name: "index_charities_on_website_url", unique: true
  end

  create_table "charity_categories", force: :cascade do |t|
    t.bigint "charity_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_charity_categories_on_category_id"
    t.index ["charity_id"], name: "index_charity_categories_on_charity_id"
  end

  create_table "news_posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "text", null: false
    t.bigint "charity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["charity_id"], name: "index_news_posts_on_charity_id"
  end

  create_table "user_charities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "charity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["charity_id"], name: "index_user_charities_on_charity_id"
    t.index ["user_id", "charity_id"], name: "index_user_charities_on_user_id_and_charity_id", unique: true
    t.index ["user_id"], name: "index_user_charities_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "charity_categories", "categories"
  add_foreign_key "charity_categories", "charities"
  add_foreign_key "news_posts", "charities"
  add_foreign_key "user_charities", "charities"
  add_foreign_key "user_charities", "users"
end
