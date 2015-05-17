class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :current_user
  helper_method :logged_in?
  helper_method :authorized_user?

  private
  def current_user
    @current_user = User.find(session[:user_id])
  end
  
  def logged_in?
    !!current_user
  end

  def authorized_user?(wardrobe)
    logged_in? && wardrobe.user.include?(current_user)
  end
end