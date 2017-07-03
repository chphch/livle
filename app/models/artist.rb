class Artist < ApplicationRecord
  has_many :artist_feeds
  has_many :artist_upcomings
end
