class Organization < ActiveRecord::Base
  include Encryption

  attr_encrypted :pagerduty_account, key: :encryption_key
  attr_encrypted :pagerduty_token, key: :encryption_key

  has_many :organization_users
  has_many :users, through: :organization_users
end
