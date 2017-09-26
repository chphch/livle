class Artist < ApplicationRecord
  has_many :feed_artists, dependent: :destroy
  has_many :feeds, through: :feed_artists
  has_many :upcoming_artists, dependent: :destroy
  has_many :upcomings, through: :upcoming_artists
  mount_uploader :image_url, S3Uploader

  def popular_feed
    self.feeds.order('rank DESC').first
  end

  def popular_feed_artist
    if popular_feed
      FeedArtist.where(artist_id: self.id, feed_id: popular_feed.id).take
    end
  end
end
