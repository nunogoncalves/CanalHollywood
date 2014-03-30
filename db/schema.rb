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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140329231421) do

  create_table "actors", :force => true do |t|
    t.string   "name"
    t.datetime "birth_date"
    t.boolean  "deceased"
    t.datetime "date_of_death"
    t.integer  "movies_count"
    t.integer  "aged"
    t.string   "image"
    t.string   "imdb_url"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "casts", :force => true do |t|
    t.integer  "actor_id"
    t.integer  "movie_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "movies", :force => true do |t|
    t.integer  "channel_id"
    t.string   "original_name"
    t.string   "local_name"
    t.integer  "year"
    t.string   "director"
    t.string   "description"
    t.string   "genre"
    t.string   "big_image_url"
    t.string   "small_image_url"
    t.integer  "schedules_count",          :default => 0
    t.string   "canal_hollywood_url"
    t.datetime "canal_hollywood_premiere"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "imdb_url"
    t.string   "youtube_url"
    t.integer  "actors_count"
    t.string   "canal_hollywood_id"
  end

  create_table "schedules", :force => true do |t|
    t.integer  "movie_id"
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.integer  "duration_mins"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
