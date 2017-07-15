class FeedArtist < ApplicationRecord
  belongs_to :feed
  belongs_to :artist
  after_commit :reindex_feed

  def reindex_feed
    feed.reindex_async
  end
end
