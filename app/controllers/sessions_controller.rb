class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path, flash: {success: "Signed in as #{current_user.first_name}"}
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, flash: {success: "You have successfully logged out."}
  end
end
