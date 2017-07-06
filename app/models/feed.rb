class Feed < ApplicationRecord
  belongs_to :users
  has_many :feed_comments
  has_many :feed_artists
  has_many :feed_likes
end
