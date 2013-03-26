class AddCardIdToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :card_id, :integer
  end
end
