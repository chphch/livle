class Upcoming < ApplicationRecord
  has_many :upcoming_likes
  has_many :upcoming_comments
  has_many :upcoming_artists


end
