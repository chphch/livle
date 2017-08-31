class Feed < ApplicationRecord
  searchkick callbacks: :async, word_middle: [:artists_names, :title, :user_nickname]
  belongs_to :user
  has_many :feed_artists
  has_many :artists, through: :feed_artists
  has_many :feed_likes
  has_many :feed_comments
  has_many :connect_urls
  attr_accessor :id, :video_id, :like_true, :count_like

  def like_true(user)
    return user && self.feed_likes.exists?(user_id: user.id) || false
  end

  def related_feeds
    feed_list = []
    self.artists.each do |artist|
      artist.feeds.each do |feed|
        if feed.id != self.id
          feed_list.push(feed)
        end
      end
    end
    return feed_list.sample(10)
  end

  # merge related model fields for searchkick indexing
  def search_data
    attributes.merge(user_nickname: self.user.nickname)
    attributes.merge(artists_names: self.artists.map(&:name))
  end

  def id
    @id || self[:id]
  end

  def video_id
    @video_id || self.class.get_youtube_video_id(self.youtube_url)
  end
end
