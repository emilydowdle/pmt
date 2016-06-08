class Organization < ActiveRecord::Base
  extend AttrEncrypted
  validates :name, presence: true,
                   uniqueness: true
  validates :pagerduty_account, presence: true
  validates :pagerduty_token, presence: true

  attr_encrypted :pagerduty_account, key: ENV['ENCRYPTION_KEY'], encode: true
  attr_encrypted :pagerduty_token, key: ENV['ENCRYPTION_KEY'], encode: true

  has_many :organization_users
  has_many :users, through: :organization_users
  has_many :blackboxes
end
