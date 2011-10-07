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

ActiveRecord::Schema.define(:version => 20111006234527) do

  create_table "beats", :force => true do |t|
    t.string   "title",       :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "audio"
  end

  add_index "beats", ["user_id", "created_at"], :name => "index_beats_on_user_id_and_created_at"

  create_table "sample_borrows", :force => true do |t|
    t.integer  "sample_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sample_borrows", ["sample_id", "user_id"], :name => "index_sample_borrows_on_sample_id_and_user_id", :unique => true
  add_index "sample_borrows", ["sample_id"], :name => "index_sample_borrows_on_sample_id"
  add_index "sample_borrows", ["user_id"], :name => "index_sample_borrows_on_user_id"

  create_table "sample_uses", :force => true do |t|
    t.integer  "beat_id"
    t.integer  "sample_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sample_uses", ["beat_id", "sample_id"], :name => "index_sample_uses_on_beat_id_and_sample_id", :unique => true
  add_index "sample_uses", ["beat_id"], :name => "index_sample_uses_on_beat_id"
  add_index "sample_uses", ["sample_id"], :name => "index_sample_uses_on_sample_id"

  create_table "samples", :force => true do |t|
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",       :null => false
    t.string   "audio"
  end

  add_index "samples", ["user_id", "created_at"], :name => "index_samples_on_user_id_and_created_at"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",               :limit => 20
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
