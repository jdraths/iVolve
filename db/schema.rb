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

ActiveRecord::Schema.define(version: 20131025044348) do

  create_table "activities", force: true do |t|
    t.integer  "user_id"
    t.integer  "achievement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "value"
    t.string   "app_log_id"
    t.string   "time"
    t.string   "description"
  end

  add_index "activities", ["achievement_id", "created_at"], name: "index_activities_on_achievement_id_and_created_at"
  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "apis", force: true do |t|
    t.integer  "user_id"
    t.string   "company"
    t.integer  "company_id"
    t.string   "access_token"
    t.string   "access_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apis", ["user_id"], name: "index_apis_on_user_id"

  create_table "authorizations", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.string   "screen_name"
    t.datetime "oauth_expires_at"
    t.string   "name"
  end

  add_index "authorizations", ["remember_token"], name: "index_authorizations_on_remember_token"

  create_table "facebook_users", force: true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "gender"
    t.string   "locale"
    t.string   "languages"
    t.string   "profile_url"
    t.string   "screen_name"
    t.string   "third_party_id"
    t.boolean  "installed"
    t.string   "timezone"
    t.string   "updated_time"
    t.boolean  "verified"
    t.string   "bio"
    t.string   "birthday"
    t.string   "cover_photo"
    t.string   "currency"
    t.string   "devices"
    t.string   "education"
    t.string   "email"
    t.string   "hometown"
    t.string   "interested_in"
    t.string   "location"
    t.string   "political"
    t.string   "favorite_athletes"
    t.string   "favorite_teams"
    t.string   "profile_pic"
    t.string   "quotes"
    t.string   "relationship_status"
    t.string   "religion"
    t.string   "significant_other"
    t.string   "website"
    t.string   "work"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

# Could not dump table "fetch_tweets" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "identities", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["email"], name: "index_identities_on_email", unique: true

  create_table "microposts", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "twitter_users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "connections"
    t.string   "contributors_enabled"
    t.string   "default_profile"
    t.string   "default_profile_image"
    t.string   "description"
    t.string   "favorite_count"
    t.string   "follow_request_sent"
    t.string   "followers_count"
    t.string   "friends_count"
    t.string   "geo_enabled"
    t.string   "is_translator"
    t.string   "lang"
    t.string   "listed_count"
    t.string   "location"
    t.string   "notifications"
    t.string   "protected_user"
    t.string   "tweet_count"
    t.string   "time_zone"
    t.string   "url"
    t.string   "utc_offset"
    t.string   "verified"
    t.string   "description_urls"
    t.string   "status"
    t.integer  "uid"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
