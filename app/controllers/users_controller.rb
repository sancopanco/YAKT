class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
  
  def sort
      user_ids = params[:users].to_a.collect{|up| up[5..-1]}
      users = user_ids.collect{|uid| User.find(uid)}
      card_id = params[:card].scan(/\d+/).first
      card = Card.find_by_id(card_id)
      unless card.nil?
        #puts ">>>>>>>>>>>>>>>>>>>user_ids=#{params[:users]} card=#{card} users=#{users}"
        card.users = users
        card.save
      end
      render :nothing => true
  end

  
end