class CreateIntTypes < ActiveRecord::Migration
  def change
    create_table :int_types do |t|
      t.integer :integer

      t.timestamps
    end
  end
end
