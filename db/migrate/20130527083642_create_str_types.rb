class CreateStrTypes < ActiveRecord::Migration
  def change
    create_table :str_types do |t|
      t.string :string

      t.timestamps
    end
  end
end
