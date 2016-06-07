class User < ActiveRecord::Base
  has_many :organization_users
  has_many :organizations, through: :organization_users

  validates :email, format: /@/

  before_create :confirmation_token

  def has_zero_organizations?
    organization_count == 0
  end

  def organization_count
    organizations.count
  end

  def has_more_than_one_org?
    organization_count > 1
  end

  def org_owner?(slug)
    organization = Organization.find_by(slug: slug)
    organization_users.find(organization).owner?
  end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.full_name = auth.info.name
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.image_url = auth.info.image
      user.google_plus_url = auth.info.urls['Google'] unless auth.info.urls.nil?
      user.gender = auth.extra.raw_info.gender
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
        # UserMailer.registration_confirmation(user).deliver
    end
  end

end
