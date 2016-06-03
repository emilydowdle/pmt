class OrganizationUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  enum user_role: %w(default owner)

end
