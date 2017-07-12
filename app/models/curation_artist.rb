class CurationArtist < ApplicationRecord
  belongs_to :curation
  belongs_to :artist
end
