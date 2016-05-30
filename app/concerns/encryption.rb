require 'active_support/concern'

module Encryption
  extend ActiveSupport::Concern

  def encryption_key
    # if in production. require key to be set.
    if Rails.env.production?
      raise 'Must set encryption key!' unless ENV['ENCRYPTION_KEY']
      ENV['ENCRYPTION_KEY']
    else
      ENV['ENCRYPTION_KEY'] ? ENV['ENCRYPTION_KEY'] : 'test_key'
    end
  end

end
