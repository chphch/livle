class UpcomingComment < ApplicationRecord
  belongs_to :upcoming
  belongs_to :user
end
