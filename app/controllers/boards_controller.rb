class BoardsController < ApplicationController

	before_filter :authenticate_user!
  #before_filter :get_account, :only => [:index, :show, :new, :edit]

  def index
   @boards = current_user.boards
   respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boards }
    end
  end

  def show
    
    @board = current_user.boards.find(params[:id])
    @states = @board.states
    if request.xhr?
      json = {}

      @states.each do |state|
        json["state_#{state.id}"] = state.cards.map { |card| "story_#{card.id}" }
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
      respond_to do |format|
        if @board.save
          current_user.memberships.create role: Role.find_by_name("owner"), board: @board
          #TODO: burayyı düzelt user_root olmali
          #BoardMailer.inform_new_board_created(@board, current_user).deliver
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

 
end
