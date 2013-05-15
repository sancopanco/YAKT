class ApplicationController < ActionController::Base
  protect_from_forgery
  #layout :select_layout
  #rescue_from CanCan::AccessDenied do |exception|
  #    redirect_to root_path, :alert => exception.message
  #end
 
  private 
  def select_layout
     return 'application'  if user_signed_in? 
     return  'beforelogin' 
  end
  
end
