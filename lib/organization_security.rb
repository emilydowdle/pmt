module OrganizationSecurity

  def require_membership(organization_slug, user)
    organization = Organization.find_by(slug: organization_slug)
    matches = organization.users.find( user ) unless organization.nil?
    if matches.nil? 
      flash[:error] = "You cannot access that organization."
      redirect_to root_path # halts request cycle
    end
  end
end
