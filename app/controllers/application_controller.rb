class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_current_user
  def set_current_user
    @user = User.find(session[:user_id]) if session.include?(:user_id)
    redirect_to root_path unless @user
  end
end
