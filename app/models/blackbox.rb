class Blackbox < ActiveRecord::Base
  belongs_to :organization
  has_many :incidents
  has_many :blackbox_involved_users
  has_many :involved_users, :through => :blackbox_involved_users, :source => :user
end
