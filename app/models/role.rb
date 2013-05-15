class Role < ActiveRecord::Base
  OWNER  = 1
  MEMBER = 2
  VIEWER = 3
  attr_accessible :name
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true
  
  scopify
end
