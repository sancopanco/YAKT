class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :card_id
      t.integer :done

      t.timestamps
    end
  end
end
