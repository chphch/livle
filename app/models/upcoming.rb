class Upcoming < ApplicationRecord
  searchkick callbacks: :async, word_middle: [:artists_names, :title, :place]
  has_many :upcoming_artists
  has_many :artists, through: :upcoming_artists
  has_many :upcoming_likes
  has_many :upcoming_comments
  has_many :upcoming_ticket_url

  # merge related model fields for searchkick indexing
  def search_data
    attributes.merge(artists_names: self.artists.map(&:name))
  end

  def wrap_artists(user)
    self.artists.each do |artist|
      popular_feed = artist.popular_feed
      popular_feed.count_like = popular_feed.feed_likes.size
    end
    return self.artists
  end

  def main_video
    if self.main_youtube_url
      main_video = Feed.new(
          id: self.class.main_video_id,
          video_id: self.main_video_id,
          title: "#{self.title} - Main Video"
      )
    else
      main_video = nil
    end
    return main_video
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
