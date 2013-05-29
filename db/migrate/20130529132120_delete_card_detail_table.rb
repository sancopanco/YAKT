class DeleteCardDetailTable < ActiveRecord::Migration
  def change
    drop_table :card_details
  end

end
