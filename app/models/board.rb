class Board < ActiveRecord::Base
  resourcify
  attr_accessible :description, :name, :owner,:updated_by
  versioned
  belongs_to :owner, :class_name => User, :foreign_key => "owner_id"
  has_many :states 
  before_create :set_default_states
  
  def set_default_states 
    backlog ||= State.create(:name => 'Backlog')
    todo ||= State.create(:name=>'ToDo')
    archive ||= State.create(:name=>'Archive')
    self.states = [backlog, todo, archive]
  end
  
  #all available boards for this user
  def self.all_available(user)
    where("owner_id = ?", user.id)
  end
  
  def owner?(u)
    u.id == self.owner_id
  end
end
