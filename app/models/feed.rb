class Feed < ApplicationRecord
  has_many :users
  has_many :comment_feeds
  has_many :artists
end
