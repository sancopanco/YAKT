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
  attr_accessible :cardtype_id, :completion_date, :description, :due_date, :name, 
                  :position, :priority_id, :requested_by, :state_id,:owner,:updated_by
                  
  versioned                
	belongs_to :priority
	belongs_to :state
	belongs_to :cardtype
  has_many :tasks, :dependent => :destroy
  has_many :user_cards
  has_many :users,:through => :user_cards
  
  has_many :attached_images
  has_many :attached_docs
  before_create :put_default_values
  def put_default_values
    #self.cardtype ||= CardType.new(:name => "Empty Card")
    self.position ||= 0
  end
  
  def requested_user
    User.where("id=?",self.requested_by).first
  end
  
  def owner
    @owner
  end
  def owner=(owner)
    @owner = owner
  end
 
  #acts_as_taggable_on :labels
end
