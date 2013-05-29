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


class Card < ActiveRecord::Base
  CARD_TYPES = ['feature', 'bug', 'release']
  acts_as_nested_set
  resourcify
  versioned                
  attr_accessible :description,:state_id,:updated_by,:name,
     :parent_id,:style,:state,:position,:priority,:cardtype
  attr_protected :lft,:rgt                
  belongs_to :state
  belongs_to :style
	has_many :states 
  has_many :attached_images
  has_many :attached_docs
  has_and_belongs_to_many :users
  has_many :elements
  has_many :element_objects, :through => :elements
  
  after_create :set_default_fields,:set_default_states,:add_elements
  def add_elements
    if style
      style.elements.each do |e|
        new_element = e.dup
        self.elements << new_element 
        new_element.update_attribute(:style_id,nil)
      end
    end
  end
  def set_default_fields
    position ||= 0
  end
  def set_default_states
    #FIXME:
    if style.name == "BoardCard"
      backlog ||= State.create(:name => 'TODO', :capacity=> 5, :position => 2,:category =>"Custom")
      todo    ||= State.create(:name => 'BackLog', :capacity => 5, :position => 1,:category =>"BackLog")
      archive ||= State.create(:name => 'Archive', :capacity=> 5, :position => 3,:category =>"Archive")
      self.states = [backlog,todo,archive]
    end
  end
  def has_any_card_task?
    #FIXME  
    return false
  end
  def requested_user
    User.where("id=?",self.requested_by).first
  end
  
  #all available boards for this user
  def self.all_available(user)
    where("owner_id = ?", user.id)
  end
 
  def members
    {
      :owner  => User.with_all_roles({:name=>:owner,:resource => self}),
      :viewer => User.with_all_roles({:name=>:viewer,:resource => self}),
      :member => User.with_all_roles({:name=>:member,:resource => self}) 
    }
  end
  
end
