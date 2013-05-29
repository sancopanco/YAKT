class CreateDateTypes < ActiveRecord::Migration
  def change
    create_table :date_types do |t|
      t.datetime :date

      t.timestamps
    end
  end
end
