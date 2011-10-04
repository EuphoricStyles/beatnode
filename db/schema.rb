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

ActiveRecord::Schema.define(:version => 20111004231405) do

  create_table "beats", :force => true do |t|
    t.string   "title",              :null => false
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "audio_file_name"
    t.string   "audio_content_type"
    t.integer  "audio_file_size"
    t.datetime "audio_updated_at"
    t.string   "description"
  end

  add_index "beats", ["creator_id", "created_at"], :name => "index_beats_on_creator_id_and_created_at"

  create_table "beats_samples", :id => false, :force => true do |t|
    t.integer "beat_id",   :null => false
    t.integer "sample_id", :null => false
  end

  add_index "beats_samples", ["beat_id", "sample_id"], :name => "index_beats_samples_on_beat_id_and_sample_id", :unique => true

  create_table "samples", :force => true do |t|
    t.string   "description"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "audio_file_name"
    t.string   "audio_content_type"
    t.integer  "audio_file_size"
    t.datetime "audio_updated_at"
    t.string   "title",              :null => false
  end

  add_index "samples", ["owner_id", "created_at"], :name => "index_samples_on_owner_id_and_created_at"

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
