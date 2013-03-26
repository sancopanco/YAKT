class Card < ActiveRecord::Base
  attr_accessible :cardtype_id, :completion_date, :description, :due_date, :name, 
                  :position, :priority_id, :requested_by, :state_id
	
	belongs_to :priority
	belongs_to :state
	belongs_to :cardtype
  belongs_to :board
	has_many :tasks, :dependent => :destroy
  has_many :attached_images
  has_many :attached_docs
  before_create :put_default_values
  def put_default_values
    self.card ||= CardType.new(:name => "Empty Card")
    self.position ||= 0
    self.priority ||= Priority.find_or_create_by_name("Low") 
    self.requested_by ||= User.find_or_create_by_name("Empty User")
  end
  
  scope :normal,  where("1=1")  #where(:icebox => false, :fast_lane => false)
  scope :icebox,  where("1=1")  #where(:icebox => true)
  scope :fast_lane, where("1=1") #where(:fast_lane => true)
  def requested_user
    User.where("id=?",self.requested_by).first
  end
  
  
  #acts_as_taggable_on :labels
end
