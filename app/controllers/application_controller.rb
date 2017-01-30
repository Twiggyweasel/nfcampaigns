class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :require_user, :require_admin, :is_admin?
  
  
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    !!current_user
  end
  
  def is_admin?
    !!current_user && current_user.role_id == 1
  end


  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? user : user.id
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to do that!"
      redirect_to :back
    end
  end
  
  def require_admin
    if !is_admin?
      flash[:danger] = "You are not authorized for this section of the application"
      redirect_to :back
    end
  end
end
