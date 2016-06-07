class UsersController < ApplicationController
  def new
    @organization = Organization.find_by(slug: params[:organization_slug])
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @organization = Organization.find_by(slug: params[:organization_slug]) || Organization.find(params[:organization_slug])
    if User.exists?(email: user_params[:email])
      @user = User.find_by(email: user_params[:email])
      redirect_to add_existing_user_organization_user_path(@user, organization_id: @organization.id, organization_slug: @organization.slug)
    elsif @user.save
      UserMailer.registration_confirmation(@user, @organization).deliver
      @organization.users << @user
      flash[:success] = "An invitation has been sent to #{@user.email}"
      redirect_to root_path
    else
      @organization = Organization.find(params[:organization_slug])
      flash[:error] = "Oops, something went wrong."
      render :new
    end
  end

  def show

  end

  def add_existing_user
    @user = User.find(params[:id])
    @organization = Organization.find_by(slug: params[:organization_slug])
  end

  def confirm_add
    @organization = Organization.find(params[:organization_slug])
    @user = User.find(params[:id])
    @organization.users << @user
    flash[:success] = "#{@user.first_name} has been added to #{@organization.name}"
    redirect_to root_path
  end

  def confirm_email
    binding.pry
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in with Google to continue."
      redirect_to signin_url
    else
      flash[:error] = "Sorry, user does not exist."
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
