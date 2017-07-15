class Curation < SearchkickRecord
  belongs_to :user
  has_many :curation_artists
  has_many :artists, through: :curation_artists
  has_many :curation_likes
  has_many :curation_comments

end
