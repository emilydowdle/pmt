class UsersController < ApplicationController
  def new
    @organization = Organization.find_by(slug: params[:organization_slug])
    @user = User.new
  end

  def create
    @user = current_user.users.new(user_params)
    @user.slug = @user.name.parameterize
    if @user.save
      current_user.users << @user
      current_user.user_users.find(@user).update!(user_role: 1)
      flash[:success] = "#{@user.name} has been created."
      redirect_to root_path
    else
      flash.now[:error] = @user.errors.full_messages.join(', ')
      render :new
    end
  end
end
