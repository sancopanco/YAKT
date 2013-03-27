class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  attr_accessible :avatar
  has_attached_file :avatar, :styles => { :medium => "120x120>", :thumb => "48x48>" }
  
 
  has_many :user_cards
  has_many :cards,  :through => :user_cards
  has_many :memberships
	has_many :boards, :through => :memberships
  
  def self.inactive_users(board)
     board.users.select{|u| u.cards.size == 0}
  end
  
end
