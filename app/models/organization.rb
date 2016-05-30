class Organization < ActiveRecord::Base
  include Encryption
  attr_encrypted :pagerduty_account, key: :encryption_key
  attr_encrypted :pagerduty_token, key: :encryption_key
end
