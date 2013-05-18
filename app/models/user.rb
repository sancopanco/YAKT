=begin 
The MIT License (MIT)
Copyright (c) 2013 ali kargin,tansel ersavas,hande kuskonmaz,yusuf aydin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE
=end
class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:role,:avatar
  has_attached_file :avatar, :styles => { :medium => "120x120>", :thumb => "48x48>" }
  
 
  has_many :user_cards
  has_many :cards,  :through => :user_cards
  has_many :boards,:foreign_key => 'owner_id'
  after_create :set_initial_role
  def set_initial_role
    self.add_role :viewer
  end
  def self.inactive_users(board)
    all.select{|u| u.cards.size == 0}
  end
  
  def role=(role)
    self.role = role
  end
  def role
    Role.first
  end
  def self.involved_user_of_board(board)
    User.with_all_roles({:name=>:owner,:resource => board}) <<
    User.with_all_roles({:name=>:viewer,:resource => board}) << 
    User.with_all_roles({:name=>:member,:resource => board})
  end
  
  def self.not_members_of_board
    all.select{|u| !u.has_role? :member,board}
  end
  
  def get_boards_by_role(role) 
    Board.with_role role, self
  end
  
  def get_role_on_the_board(board)
    #user should have one role on the board
    self.roles.select{|r| r.resource_id == board.id and r.resource_type=="Board" }.first
  end
  
  
end
