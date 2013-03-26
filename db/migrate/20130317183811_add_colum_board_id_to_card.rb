class AddColumBoardIdToCard < ActiveRecord::Migration
  def change
    add_column :cards, :board_id, :integer
  end
  
end
