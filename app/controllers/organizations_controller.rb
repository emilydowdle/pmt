class OrganizationsController < ApplicationController
  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    # binding.pry
    if @organization.save
      flash[:success] = "#{@organization.name} has been created."
      redirect_to root_path
    else
      flash.now[:error] = @organization.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
  end

  def show

  end

  private

  def organization_params
    params.require(:organization).permit(:name, :pagerduty_account, :pagerduty_token)
  end
end
