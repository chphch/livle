class Upcoming < ArtistsRecord
  searchkick callbacks: :async
  has_many :upcoming_artists
  has_many :artists, through: :upcoming_artists
  has_many :upcoming_likes
  has_many :upcoming_comments

end
