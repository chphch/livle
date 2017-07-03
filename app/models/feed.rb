class Feed < ApplicationRecord
  has_many :users
  has_many :feed_commnets
  has_many :feed_artists
  has_many :feed_likes
end
