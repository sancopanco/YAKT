class Task < ActiveRecord::Base
  attr_accessible :card_id, :done, :name, :updated_by
  versioned
  before_save :default_values
  
  def default_values
    self.done ||= 0
  end
  scope :complete, where(:done => 1)
  belongs_to :card
end
