class Feed < ApplicationRecord
  searchkick callbacks: :async, word_middle: [:artists_names, :title, :user_nickname]
  belongs_to :user
  has_many :feed_artists
  has_many :artists, through: :feed_artists
  has_many :feed_likes
  has_many :feed_comments
  has_many :connect_urls
  attr_accessor :id, :like_true, :count_like

  def prev(feeds)
    # 나중에 생성된 feed
    return feeds.where('feeds.created_at > ?', self.created_at).first
  end

  def next(feeds)
    # 전에 생성된 feed
    return feeds.where('feeds.created_at < ?', self.created_at).first
  end

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

  # 이거 역할이 뭐야?
  def id
    @id || self[:id]
  end

end
