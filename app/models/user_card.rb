class UserCard < ActiveRecord::Base
  attr_accessible :card_id, :user_id
  belongs_to :card
  belongs_to :user
end
