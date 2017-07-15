class Upcoming < ArtistsRecord
  searchkick callbacks: :async, word_middle: [:artists_names, :title, :place]
  has_many :upcoming_artists
  has_many :artists, through: :upcoming_artists
  has_many :upcoming_likes
  has_many :upcoming_comments

end
