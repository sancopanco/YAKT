class BoardState < ActiveRecord::Base
  attr_accessible :board_id, :state_id
  belongs_to :board
  belongs_to :state
end
