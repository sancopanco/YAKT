class AddStyleIdToCard < ActiveRecord::Migration
  def change
    add_column :cards,:style_id,:integer
  end
end
