class Feed < ApplicationRecord
  belongs_to :users
  has_many :feed_commnets
  has_many :feed_artists
  has_many :feed_likes
end
