class AddBoardIdToState < ActiveRecord::Migration
  def change
    add_column :states, :board_id, :integer
  end
end
