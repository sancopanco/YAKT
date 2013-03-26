class UserAccount < ActiveRecord::Base
  attr_accessible :account_id, :user_id
  belongs_to :account
  belongs_to :user
end
