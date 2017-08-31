class Feed < ArtistsRecord
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

  def search_data
    super
    attributes.merge(user_nickname: self.user.nickname)
  end

  def id
    @id || self[:id]
  end

  def video_id
    @video_id || self.class.get_youtube_video_id(self.youtube_id)
  end

  # TODO jaeseong to elaborate the algorithm
  def priority
    VIEW_WEIGHT = 10 # Dummy value
    SHARE_WEIGHT = 10 # Dummy value
    LIKE_CORRECTION = 100 # Dummy value

    priority = (VIEW_WEIGHT * self.count_view) + (SHARE_WEIGHT * self.count_share)

    self.feed_likes.each do |l|
      passed = Time.now - l.created_at # in seconds
      priority = priority + (passed / LIKE_CORRECTION)
    end

    return priority
  end
end
