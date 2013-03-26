class CreateCardtypes < ActiveRecord::Migration
  def change
    create_table :cardtypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
