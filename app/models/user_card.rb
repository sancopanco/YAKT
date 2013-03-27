class UserCard < ActiveRecord::Base
  attr_accessible :card_id, :user_id
  belongs_to :user
  belongs_to :card
end
