class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table "card_details", :force => true do |t|
      t.integer  "position"
      t.string   "priority"
      t.string   "cardtype"
      t.integer  "requested_by"
      t.integer  "assigned_to"
      t.datetime "due_date"
      t.datetime "completion_date"
      t.integer  "card_id"
      t.datetime "created_at",      :null => false
      t.datetime "updated_at",      :null => false
    end

    create_table "cards", :force => true do |t|
      t.string   "name"
      t.string   "description"
      t.integer  "state_id"
      t.integer  "parent_id"
      t.integer  "lft"
      t.integer  "rgt"
      t.datetime "created_at",      :null => false
      t.datetime "updated_at",      :null => false
    end
    create_table "cards_users", :id => false, :force => true do |t|
      t.integer "card_id"
      t.integer "user_id"
    end
    create_table "roles", :force => true do |t|
      t.string   "name"
      t.integer  "resource_id"
      t.string   "resource_type"
      t.datetime "created_at",    :null => false
      t.datetime "updated_at",    :null => false
    end

    add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
    add_index "roles", ["name"], :name => "index_roles_on_name"

    create_table "sessions", :force => true do |t|
      t.string   "session_id", :null => false
      t.text     "data"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
    add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

    create_table "states", :force => true do |t|
      t.string   "name"
      t.integer  "capacity"
      t.integer  "position"
      t.string   "category"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
      t.integer  "card_id"
    end
    create_table "users", :force => true do |t|
      t.string   "email",                  :default => "", :null => false
      t.string   "encrypted_password",     :default => "", :null => false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          :default => 0
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.datetime "created_at",                             :null => false
      t.datetime "updated_at",                             :null => false
      t.string   "avatar_file_name"
      t.string   "avatar_content_type"
      t.integer  "avatar_file_size"
      t.datetime "avatar_updated_at"
    end

    add_index "users", ["email"], :name => "index_users_on_email", :unique => true
    add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

    create_table "users_roles", :id => false, :force => true do |t|
      t.integer "user_id"
      t.integer "role_id"
    end

    add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

    create_table "versions", :force => true do |t|
      t.integer  "versioned_id"
      t.string   "versioned_type"
      t.integer  "user_id"
      t.string   "user_type"
      t.string   "user_name"
      t.text     "modifications"
      t.integer  "number"
      t.integer  "reverted_from"
      t.string   "tag"
      t.datetime "created_at",     :null => false
      t.datetime "updated_at",     :null => false
    end

    add_index "versions", ["created_at"], :name => "index_versions_on_created_at"
    add_index "versions", ["number"], :name => "index_versions_on_number"
    add_index "versions", ["tag"], :name => "index_versions_on_tag"
    add_index "versions", ["user_id", "user_type"], :name => "index_versions_on_user_id_and_user_type"
    add_index "versions", ["user_name"], :name => "index_versions_on_user_name"
    add_index "versions", ["versioned_id", "versioned_type"], :name => "index_versions_on_versioned_id_and_versioned_type"
  end
end
