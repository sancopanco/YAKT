class Style < ActiveRecord::Base
  attr_accessible :name
  has_many :elements
end
