class Artist < ApplicationRecord
  has_many :curation_artists
  has_many :curations, through: :curation_artists
  has_many :feed_artists
  has_many :feeds, through: :feed_artists
  has_many :upcoming_artists
  has_many :upcomings, through: :upcoming_artists
  mount_uploader :image_url, S3Uploader

  def popular_post
    [feeds.take, curations.take].sample()
  end
end
