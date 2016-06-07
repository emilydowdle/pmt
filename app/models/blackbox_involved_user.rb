class BlackboxInvolvedUser < ActiveRecord::Base
  belongs_to :blackbox
  belongs_to :user
end
