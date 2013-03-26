class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.string :description
      t.integer :cardtype_id
      t.integer :state_id
      t.integer :position
      t.integer :priority_id
      t.integer :requested_by
      t.integer :assigned_to
      t.datetime :due_date
      t.datetime :completion_date

      t.timestamps
    end
  end
end
