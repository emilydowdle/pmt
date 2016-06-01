class OrganizationsController < ApplicationController
  before_action :require_membership, except: [:new, :create]

  def new
    @organization = current_user.organizations.new
  end

  def create
    @organization = current_user.organizations.new(organization_params)
    @organization.slug = @organization.name.parameterize
    if @organization.save
      current_user.organizations << @organization
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
    @organization = Organization.find_by(slug: params[:slug])
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :pagerduty_account, :pagerduty_token, :slug)
  end

  def require_membership
    organization = Organization.find_by(slug: params[:slug])
    matches = organization.users.find( current_user ) unless organization.nil?
    if matches.nil? 
      flash[:error] = "You cannot access that organization."
      redirect_to root_path # halts request cycle
    end
  end

end
