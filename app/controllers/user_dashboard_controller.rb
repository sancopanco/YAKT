class UserDashboardController < ApplicationController
  before_filter :authenticate_user!
  def index
    #TODO:change this hard code
    #binding.pry
    @owning_boards = current_user.get_boards_by_role(Role::OWNER)
    @member_boards = current_user.get_boards_by_role(Role::MEMBER)
    @new_board = Board.new
    render 'home/dashboard'
  end
  
  def open_model_to_create_new_board
    @new_board = Board.new
    render :partial => 'home/new_board',:locals =>{:new_board => @new_board} 
  end
  
end