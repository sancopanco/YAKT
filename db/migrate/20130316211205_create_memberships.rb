class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :board_id
      t.integer :role_id 
      t.integer :user_id

      t.timestamps
    end
  end
end
