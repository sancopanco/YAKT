class Board < ActiveRecord::Base
  attr_accessible  :description, :name
  
  #has_many :board_states
  has_many :states #,:through => :board_states
  has_many :cards
  has_many :memberships
  has_many :users, :through => :memberships
  before_create :put_default_values
  
  def put_default_values 
    backlog = State.find_or_create_by_name('Backlog')
    todo = State.find_or_create_by_name('ToDo')
    archive = State.find_or_create_by_name('Archive')
    self.states = [backlog, todo, archive]
  end
  
  # Return all boards owned by account
  #scope :all_where_account, lambda{ |account| { :conditions => { :account_id => account.to_i } } }
end
