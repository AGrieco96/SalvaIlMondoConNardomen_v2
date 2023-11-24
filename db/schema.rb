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

ActiveRecord::Schema.define(version: 2018_10_17_095758) do

  create_table "bans", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "request"
    t.datetime "day_ban"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bans_on_user_id"
  end

  create_table "game_data", force: :cascade do |t|
    t.integer "user_id"
    t.integer "money"
    t.integer "level"
    t.integer "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "skin_id"
    t.integer "enemy_id"
    t.integer "sword_id"
    t.integer "landscape_id"
    t.index ["user_id"], name: "index_game_data_on_user_id", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.integer "level"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_items_on_category"
    t.index ["name"], name: "index_items_on_name"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "actor_id"
    t.integer "dest_id"
    t.integer "category"
    t.integer "new_best_score"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dest_id"], name: "index_notifications_on_dest_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "score"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_scores_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "shops", force: :cascade do |t|
    t.integer "user_id"
    t.integer "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_shops_on_item_id"
    t.index ["user_id", "item_id"], name: "index_shops_on_user_id_and_item_id"
    t.index ["user_id"], name: "index_shops_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "last_name"
    t.string "nickname"
    t.string "provider"
    t.string "uid"
    t.string "avatar"
    t.string "token"
    t.boolean "gf", default: false
    t.boolean "gm", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
