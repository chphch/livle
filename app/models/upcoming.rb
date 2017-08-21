class Upcoming < ArtistsRecord
  searchkick callbacks: :async, word_middle: [:artists_names, :title, :place]
  has_many :upcoming_artists
  has_many :artists, through: :upcoming_artists
  has_many :upcoming_likes
  has_many :upcoming_comments

  # return artist_name, video_id, count_view, count_like, count_share of the main video and artists popular videos
  def main_video_and_feeds(user)
    result = []
    artists.each do |artist|
      result.append(artist.popular_feed)
    end
    if main_youtube_id
      main_feed = Feed.new
      result.unshift(
          main_feed.video_id = get_youtube_video_id(main_youtube_id)
      )
    end
    return result
  end

  def upcoming_feed(artist, user)
    feed = artist.popular_feed
    if user
      like_true = feed.like_class.where(feed_id: feed.id, user_id: user.id).present?
    else
      like_true = false
    end
    {
        artist_name: artist.name,
        artist_image_url: artist.image_url,
        post_class: feed.class.name.downcase,
        id: feed.id,
        like_true: like_true,
        video_id: get_youtube_video_id(main_youtube_id),
        count_view: feed.count_view,
        count_like: feed.count_like,
        count_share: feed.count_share
    }
  end

  def d_day
    start_day = self.start_date.strftime('%Q').to_i
    today = DateTime.now.strftime('%Q').to_i
    day_to_millisec = 1000*60*60*24
    d_day = ((start_day - today)/day_to_millisec).floor
    return -d_day
  end
end
