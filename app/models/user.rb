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
  has_many :boards,:foreign_key => 'owner_id'
  after_create :set_initial_role
  def set_initial_role
    self.add_role :viewer
  end
  def self.inactive_users(board)
    all.select{|u| u.cards.size == 0}
  end
  
  def self.not_members_of_board
    all.select{|u| !u.has_role? :member,board}
  end
  def get_boards_by_role(role) 
    Board.with_role role, self
  end
end
