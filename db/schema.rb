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

ActiveRecord::Schema.define(version: 20150612184016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.integer  "author_id",                        null: false
    t.string   "title",                            null: false
    t.string   "genre",                            null: false
    t.text     "synopsis",                         null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "content_file_name"
    t.string   "content_content_type"
    t.integer  "content_file_size"
    t.datetime "content_updated_at"
    t.integer  "likes_count",          default: 0
  end

  add_index "books", ["id", "author_id"], name: "index_books_on_id_and_author_id", unique: true, using: :btree

  create_table "collections", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.string   "name",                       null: false
    t.text     "description",                null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "collects_count", default: 0
  end

  add_index "collections", ["id", "user_id"], name: "index_collections_on_id_and_user_id", unique: true, using: :btree

  create_table "collects", force: :cascade do |t|
    t.integer  "collection_id", null: false
    t.integer  "book_id",       null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "commenter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body",             null: false
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commenter_id"], name: "index_comments_on_commenter_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "liker_id",     null: false
    t.integer  "likable_id",   null: false
    t.string   "likable_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["likable_id"], name: "index_likes_on_likable_id", using: :btree
  add_index "likes", ["liker_id", "likable_type", "likable_id"], name: "index_likes_on_liker_id_and_likable_type_and_likable_id", unique: true, using: :btree
  add_index "likes", ["liker_id"], name: "index_likes_on_liker_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.text    "body",    null: false
    t.integer "from_id", null: false
    t.integer "to_id",   null: false
  end

  add_index "messages", ["from_id"], name: "index_messages_on_from_id", using: :btree
  add_index "messages", ["to_id"], name: "index_messages_on_to_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                       null: false
    t.string   "password_digest",             null: false
    t.string   "session_token",               null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "fname"
    t.string   "lname"
    t.integer  "likes_count",     default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree

end
