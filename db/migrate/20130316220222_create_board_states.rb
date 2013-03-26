class CreateBoardStates < ActiveRecord::Migration
  def change
    create_table :board_states do |t|
      t.integer :board_id
      t.integer :state_id

      t.timestamps
    end
  end
end
