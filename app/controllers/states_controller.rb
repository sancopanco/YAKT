class StatesController < ApplicationController
  # GET /states
  # GET /states.json
  def index
    @states = State.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @states }
    end
  end

  # GET /states/1
  # GET /states/1.json
  def show
    @state = State.find(params[:id], :include => :cards)
    @active_stories = @state.cards.first(5)
    @inactive_stories = @state.cards - @active_stories

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @state }
    end
  end

  # GET /states/new
  # GET /states/new.json
  def new
    @state = State.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @state }
    end
  end

  # GET /states/1/edit
  def edit
    @state = State.find(params[:id])
  end

  # POST /states
  # POST /states.json
  def create
    @state = State.new(params[:state])

    respond_to do |format|
      if @state.save
        format.html { redirect_to @state, :notice => 'State was successfully created.' }
        format.json { render :json => @state, :status => :created, :location => @state }
      else
        format.html { render :action => "new" }
        format.json { render :json => @state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /states/1
  # PUT /states/1.json
  def update
    @state = State.find(params[:id])

    respond_to do |format|
      if @state.update_attributes(params[:state])
        format.html { redirect_to @state, :notice => 'State was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /states/1
  # DELETE /states/1.json
  def destroy
    @state = State.find(params[:id])
    @state.destroy

    respond_to do |format|
      format.html { redirect_to states_url }
      format.json { head :ok }
    end
  end
  
  def sort
    unless params[:stories].blank?
      card_ids = params[:stories].map {|i| i.scan(/\d+/).first}
      state_id  = params[:state].scan(/\d+/).first

      Story.find(card_ids).each_with_index do |card, i|
        card.update_attributes(:position => i, :state_id => state_id)
      end
    end

    render :nothing => true
  end
end
