class Incident < ActiveRecord::Base
  belongs_to :blackbox
  has_many :incident_logs
end
