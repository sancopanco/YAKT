class UserDashboardController < ApplicationController
  before_filter :authenticate_user!
  def index
    @owning_boards = Board.with_role :owner, current_user
    @member_boards = Board.with_role :member, current_user
    @new_board = Board.new
    render 'home/dashboard'
  end
  
  
end