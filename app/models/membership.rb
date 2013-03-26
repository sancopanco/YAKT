class Membership < ActiveRecord::Base
  attr_accessible :user_id, :board_id, :role_id,:board,:role
  
	belongs_to :user
	belongs_to :board
	belongs_to :role
end
