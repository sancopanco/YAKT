class Board < ActiveRecord::Base
  attr_accessible  :description, :name
  
  has_many :states 
  has_many :memberships
  has_many :cards, :through => :memberships
  has_many :users, :through => :memberships
  before_create :set_default_states
  
  def set_default_states 
    backlog ||= State.create(:name => 'Backlog')
    todo ||= State.create(:name=>'ToDo')
    archive ||= State.create(:name=>'Archive')
    self.states = [backlog, todo, archive]
  end
  
  # Return all boards owned by account
  #scope :all_where_account, lambda{ |account| { :conditions => { :account_id => account.to_i } } }
end
