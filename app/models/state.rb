class State < ActiveRecord::Base
  #binding.pry
  attr_accessible :capacity, :category, :name, :position, :board_id
  versioned
  before_create :put_default_values
  has_many :cards
  belongs_to :board
  def put_default_values
    self.capacity ||= 5
    self.position ||= 0
    self.category ||= "backlog"
  end
end
