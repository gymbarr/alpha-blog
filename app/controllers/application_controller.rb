class ApplicationController < ActionController::Base
  # assigning methods to the helper_method
  helper_method :current_user, :logged_in?
  
  # get current logged in user from database
  # if a user hasn't loged out, the method returns current saved user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # method return true if any user logged in, false otherwise
  def logged_in?
    !!current_user
  end

  # the method prevent not logged in user to make any actions with articles and user's profiles
  def require_user
    if !logged_in?
      flash[:alert] = "You must be signed in to perform that action"
      redirect_to login_path
    end
  end
end
