class CardsController < ApplicationController
  # GET /cards
  # GET /cards.json
  def index
    @cards = Card.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @cards }
    end
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    @card = Card.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @card }
    end
  end

  # GET /cards/new
  # GET /cards/new.json
  def new
    @card = Card.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @card }
    end
  end

  # GET /cards/1/edit
  def edit
    @card = Card.find(params[:id])
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(params[:card])
    @card.users << User.first # current user olmali
    @card.state = State.first
    @card.board = Board.first

    if @card.save
      if request.xhr?
        render 'new_card'
      else
        redirect_to root_path
      end
    end
  end

  # PUT /cards/1
  # PUT /cards/1.json
  def update
    @card = Card.find(params[:id])

    respond_to do |format|
      if @card.update_attributes(params[:story])
        format.html { redirect_to @card, :notice => 'Card was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @card.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url }
      format.json { head :ok }
    end
  end

  def sort
    unless params[:cards].blank?
      card_ids = params[:cards].map {|i| i.scan(/\d+/).first}
      state_id  = params[:state].scan(/\d+/).first

      Card.find(card_ids).each_with_index do |card, i|
        card.update_attributes(:position => i, :state_id => state_id)
      end
    end

    render :nothing => true
  end
  
  def  add_task_to_card
    task_name = params[:name]
    card_id = params[:card_id]
    card = Card.find_by_id(card_id)
    if task_name.present?
      card.tasks << Task.new(:name=>task_name)
    end
    if request.xhr?
      json = {}
      json["name"] = task_name
      render :json => json, :status => :ok
    end
  end
  def open_new_card_modal
    @card = Card.new
    render :partial => 'shared/modal',:locals => {:page_url =>'cards/form'}
  end
  
  
  
  
end
