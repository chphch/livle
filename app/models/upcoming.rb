class Upcoming < ApplicationRecord
  has_many :users
  has_many :comment_upcomings
  has_many :artists
end
