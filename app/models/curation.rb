class Curation < ApplicationRecord
  belongs_to :user
  has_many :curation_videos
  has_many :curation_likes
  has_many :curation_comments
end
