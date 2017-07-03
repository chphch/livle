class FeedComment < ApplicationRecord
  belongs_to :feed
  belongs_to :user
end
