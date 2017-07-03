class Upcoming < ApplicationRecord
  has_many :users
  has_many :upcoming_comments
  has_many :upcoming_artists
end
