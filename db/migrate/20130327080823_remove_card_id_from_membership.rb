class RemoveCardIdFromMembership < ActiveRecord::Migration
  def change
    remove_column :memberships,:card_id
  end
end
