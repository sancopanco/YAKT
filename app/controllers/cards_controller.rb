=begin 
The MIT License (MIT)
Copyright (c) 2013 ali kargin,tansel ersavas,hande kuskonmaz,yusuf aydin,kevin bongart

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
class CardsController < ApplicationController
  before_filter :authenticate_user!
  
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
    @card = current_user.cards.find(params[:id])
    @states = @card.states.sort{|a,b| a.position.to_i <=> b.position.to_i}
    if request.xhr?
      json = {}

      @states.each do |state|
        json["state_#{state.id}"] = state.cards.map { |card| "card_#{card.id}" }
      end

      render :json => json
    else
      @inactive_users = User.inactive_users
      @new_card = Card.new      
    end
  end

  # GET /cards/new
  # GET /cards/new.json
  def new
    @card = Card.new
    @card_styles = Style.all
    @url = {:controller=>"cards",:action=>"create"}
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
    Card.transaction do
      @card = Card.new(params[:card])
      if @card.save
       @card.users << current_user  
       current_user.add_role :owner, @card
       render 'new_card' and return if !!request.xhr?
       respond_to do |format|
         format.html { redirect_to '/dashboard', :notice => 'Card was successfully created.' }
         format.json { render :json => @card, :status => :created }
       end   
      else
        respond_to do |format|
          format.html { render :action => "new" }
          format.json { render :json => @cards.errors, :status => :unprocessable_entity }
        end  
      end
    end
  end

  # PUT /cards/1
  # PUT /cards/1.json
  def update
    @card = Card.find(params[:id])
    params[:card][:updated_by] = current_user
    respond_to do |format|
      if @card.update_attributes(params[:card])
        
        @card.versions.last.user = current_user
        @card.versions.last.save
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
    #TODO:delete user roles on this cards when it was destroyed
    @card = Card.find(params[:id])
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url,:notice => 'Card was successfully deleted.' }
      format.json { head :ok }
    end
  end
  def newsubcard
    @card = Card.new
    @card_styles = Style.all
    @url = {:controller=>"cards",:action=>"addsubcard",:id=>params[:id]}
    render :action =>'new'
  end
  def addsubcard
    @card = Card.find(params[:id])
    new_card = Card.create(params[:card])
    new_card.state = @card.states.find_by_name("BackLog")
    new_card.save
    @card.children << new_card
    redirect_to @card
  end
  
  
  def settings
    @card = Card.find_by_id(params[:id])
  end
  def memberships
    # FIXME code smells:)
    @card  = Card.find_by_id(params[:id])
    @member_users = @card.members
    @all_roles = Role.where('resource_id is NULL').all.collect{|r| [r.name,r.id]}
  end
  def addmember
    # FIXME code smells:) role remove button does not seem when it was added
    card = Card.find(params[:id])
    @role = Role.find(params[:role_id])
    @all_roles = Role.where('resource_id is NULL').all.collect{|r| [r.name,r.id]}
    @user = User.find_by_email(params[:email])
    if @user.present?
      @user.add_role @role.name,card 
      render :partial=>'addmember' ,:locals => {:user => @user, :all_roles => @all_roles, :card =>@card}
    else
      render :json =>{}.as_json
    end   
  end
  
  def change_role
    # FIXME 
    @user = User.find(params[:user_id])
    role = Role.find(params[:role_id]) 
    card = Card.find(params[:id])
    #TODO:remove role user on this board and add new one
    @user.remove_role card
    @user.add_role role.name,card
    render :json => {}.as_json
  end
  
  
  def sort
    unless params[:cards].blank?
      card_ids = params[:cards].map {|i| i.scan(/\d+/).first}
      state_id  = params[:state].scan(/\d+/).first
         
      Card.find(card_ids).each_with_index do |card, i|
        card.update_attributes(:state_id => state_id) 
        card.update_attributes(:position => i,:updated_by => current_user)
      end
    end

    render :nothing => true
  end
  
  
end
