class Blackbox < ActiveRecord::Base
  belongs_to :organization
  has_many :incidents
end
