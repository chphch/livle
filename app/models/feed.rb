class Feed < ArtistsRecord
  searchkick callbacks: :async, word_middle: [:artists_names, :title, :user_nickname]
  belongs_to :user
  has_many :feed_artists
  has_many :artists, through: :feed_artists
  has_many :feed_likes
  has_many :feed_comments
  has_many :connect_urls
  attr_accessor :video_id

  def search_data
    super
    attributes.merge(user_nickname: self.user.nickname)
  end

  def video_id
    get_youtube_video_id(youtube_id)
  end
end
