class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user,
                :owner?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def owner?
    current_user && current_user.org_owner?(params[:slug])
  end

end
