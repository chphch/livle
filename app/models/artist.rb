class Artist < ApplicationRecord
  has_many :feed_artists
  has_many :upcoming_artists
  has_many :curation_videos
end
