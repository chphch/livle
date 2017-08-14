class Upcoming < ArtistsRecord
  searchkick callbacks: :async, word_middle: [:artists_names, :title, :place]
  has_many :upcoming_artists
  has_many :artists, through: :upcoming_artists
  has_many :upcoming_likes
  has_many :upcoming_comments

  # return artist_name, video_id, count_view, count_like, count_share of the main video and artists popular videos
  def posts
    result = []
    artists.each do |artist|
      result.append(upcoming_post_json(artist))
    end
    if main_youtube_id
      result.unshift(
          {
              artist_name: "Main Video",
              artist_image_url: Faker::LoremPixel.image("50x60"),
              video_id: get_youtube_video_id(main_youtube_id)
          }
      )
    end
    return result
  end

  def upcoming_post_json(artist)
    post = artist.popular_post
    if post.class == Feed
      count_like = post.feed_likes.size
    elsif post.class == Curation
      count_like = post.curation_likes.size
    end
    {
        artist_name: artist.name,
        artist_image_url: artist.image_url,
        video_id: get_youtube_video_id(main_youtube_id),
        count_view: post.count_view,
        count_like: count_like,
        count_share: post.count_share
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
