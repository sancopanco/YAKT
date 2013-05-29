class AddPositionPriorityCardtypeColumnsToCard < ActiveRecord::Migration
  def change
    add_column :cards,:position,:integer
    add_column :cards,:priority,:string
    add_column :cards,:cardtype,:string
  end
end
