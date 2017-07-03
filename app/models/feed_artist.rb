class FeedArtist < ApplicationRecord
  belongs_to :feed
  belongs_to :artist
end
