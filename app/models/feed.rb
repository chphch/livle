class Feed < ArtistsRecord
  searchkick callbacks: :async
  belongs_to :user
  has_many :feed_artists
  has_many :artists, through: :feed_artists
  has_many :feed_likes
  has_many :feed_comments
  has_many :connect_urls

  def search_data
    super
    attributes.merge(user_nickname: self.user.nickname)
  end
end
