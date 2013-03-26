class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.integer :capacity
      t.integer :position
      t.string :category

      t.timestamps
    end
  end
end
