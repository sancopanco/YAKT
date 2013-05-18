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
