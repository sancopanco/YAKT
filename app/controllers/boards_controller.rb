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
class BoardsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
   @boards = current_user.boards
   respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boards }
    end
  end

  def show
    @board = current_user.boards.find(params[:id])
    @states = @board.states.sort{|a,b| a.position.to_i <=> b.position.to_i}
    if request.xhr?
      json = {}

      @states.each do |state|
        json["state_#{state.id}"] = state.cards.map { |card| "card_#{card.id}" }
      end

      render :json => json
    else
      @inactive_users = User.inactive_users(@board) 
      @new_card = Card.new      
    end
    
  end

  def new
    @board = Board.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @board }
    end
  end

  def edit
    @board = Board.find(params[:id])
  end

  def create
    Board.transaction do
      @board = Board.new(params[:board])
      @board.owner_id = current_user.id
      
      respond_to do |format|
        if @board.save
          current_user.add_role :owner ,@board
          format.html { redirect_to '/dashboard', notice: 'Board was successfully created.' }
          format.json do
            render json: @board, status: :created
          end
        else
          format.html { render action: "new" }
          format.json { render json: @board.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    @board = Board.find(params[:id])
    params[:board][:updated_by] = current_user
    respond_to do |format|
      if @board.update_attributes(params[:board])
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy

    respond_to do |format|
      format.html { redirect_to boards_url }
      format.json { head :no_content }
    end
  end
  
  def settings
    @board = Board.find_by_id(params[:id])
  end
  def memberships
    @board  = Board.find_by_id(params[:id])
    @users  = User.involved_user_of_board(@board)
    #@users.each{|u| u.role = u.get_role_on_the_board(@board) }
  end
  
 
end
