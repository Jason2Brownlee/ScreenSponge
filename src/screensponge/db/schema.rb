# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080829235719) do

  create_table "activities", :force => true do |t|
    t.integer  "show_id",       :limit => 11
    t.text     "note"
    t.string   "type"
    t.integer  "user_id",       :limit => 11
    t.integer  "friend_id",     :limit => 11
    t.integer  "annotation_id", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "annotations", :force => true do |t|
    t.integer  "show_id",    :limit => 11
    t.text     "entry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                     :null => false
  end

  add_index "annotations", ["show_id"], :name => "index_annotations_on_show_id"

  create_table "events", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "when"
    t.integer  "show_id",     :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id",    :limit => 11, :null => false
    t.integer  "friend_id",  :limit => 11, :null => false
    t.string   "status",                   :null => false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued",     :limit => 11
    t.integer "lifetime",   :limit => 11
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :limit => 11, :null => false
    t.string  "server_url"
    t.string  "salt",                     :null => false
  end

  create_table "permissions", :force => true do |t|
    t.integer  "role_id",    :limit => 11, :null => false
    t.integer  "user_id",    :limit => 11, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "score",      :limit => 11
    t.integer  "show_id",    :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", :force => true do |t|
    t.integer  "requested_show_id", :limit => 11
    t.integer  "wanted_show_id",    :limit => 11
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "closed",                          :default => false
  end

  create_table "roles", :force => true do |t|
    t.string   "rolename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "show_activities", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "show_types", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "shows", :force => true do |t|
    t.string   "name",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    :limit => 11, :null => false
    t.string   "global_id"
    t.integer  "parent_id",  :limit => 11
    t.integer  "intention",  :limit => 11
    t.integer  "possession", :limit => 11
    t.string   "show_type"
  end

  add_index "shows", ["user_id", "global_id"], :name => "index_shows_on_user_id_and_global_id", :unique => true
  add_index "shows", ["user_id"], :name => "index_shows_on_user_id"
  add_index "shows", ["global_id"], :name => "index_shows_on_global_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",           :limit => 40
    t.string   "salt",                       :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",            :limit => 40
    t.datetime "activated_at"
    t.string   "password_reset_code",        :limit => 40
    t.boolean  "enabled",                                  :default => true
    t.datetime "last_signin_at"
    t.datetime "last_notification_email_at"
    t.boolean  "notification_enabled",                     :default => true
    t.string   "identity_url"
    t.string   "permalink"
    t.string   "time_zone",                                :default => "UTC"
  end

  add_index "users", ["email"], :name => "index_users_on_email"

  create_table "view_states", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

end
