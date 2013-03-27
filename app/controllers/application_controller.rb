class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :select_layout
  #rescue_from CanCan::AccessDenied do |exception|
  #    redirect_to root_path, :alert => exception.message
  #end
 
  def after_sign_in_path_for(resource)
    
    sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol =>             'http')
    if request.referer == sign_in_url
       super
     else
       current_user = resource
       root_path
     end
     
  end
 
 
  
  private 
  def select_layout
     return 'application'  if user_signed_in? 
     return  'beforelogin' 
  end
  
end
