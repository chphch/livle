class Upcoming < ApplicationRecord
  searchkick callbacks: :async, word_middle: [:artists_names, :title, :place]
  has_many :upcoming_artists
  has_many :artists, through: :upcoming_artists
  has_many :upcoming_likes
  has_many :upcoming_comments
  has_many :upcoming_ticket_urls
  mount_uploader :image_url, S3Uploader

  # merge related model fields for searchkick indexing
  def search_data
    attributes.merge(artists_names: self.artists.map(&:name))
  end

  def wrap_artists(user)
    self.artists.each do |artist|
      if artist.popular_feed
        popular_feed = artist.popular_feed
        popular_feed.count_like = popular_feed.feed_likes.size
      end
    end
    return self.artists
  end

  def has_main_video
    self.main_youtube_url && self.main_youtube_url.length > 0
  end

  def main_video
    has_main_video ? Feed.new(
      youtube_url: self.main_youtube_url,
      title: "#{self.title} - Main Video"
    ) : sample_artist_feed(self.artists)
  end

  def sample_artist_feed(artists)
    return nil if artists.size == 0
    artist = artists.sample
    feed = artist.popular_feed
    return feed if feed
    sample_artist_feed(artists.drop(artist.id))
  end

  def main_video_id
    self.class.get_youtube_video_id(self.main_youtube_url)
  end

  def self.main_video_image_url
    Faker::LoremPixel.image("50x60")
  end

  # TODO 쇼페이지에서 여러 비디오들과 구분하기 위해 쓰는 아이디인데 함수명이 중복됨, 고칠것
  def self.main_video_id
    "main_video"
  end

  def related_upcomings
    upcoming_list = Set.new
    self.artists.each do |artist|
      artist.upcomings.each do |upcoming|
        upcoming_list.add(upcoming)
      end
    end
    if upcoming_list.include?(self)
      upcoming_list = upcoming_list.delete(self)
    end
    return upcoming_list.to_a.sample(10)
  end

  def d_day
    start_day = self.start_date.strftime('%Q').to_i
    today = DateTime.now.strftime('%Q').to_i
    day_to_millisec = 1000*60*60*24
    d_day = ((start_day - today)/day_to_millisec).floor
    if d_day == 0
      return "-day"
    else
      return -d_day
    end
  end
end
