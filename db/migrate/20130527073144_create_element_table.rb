class CreateElementTable < ActiveRecord::Migration
  create_table "elements", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "element_object_id"
    t.string   "element_object_type"
    t.integer  "style_id"
    t.integer  "card_id"
  end
end
