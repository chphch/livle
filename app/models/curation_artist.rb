class CurationArtist < ApplicationRecord
  belongs_to :curation
  belongs_to :artist
  after_commit :reindex_curation

  def reindex_curation
    curation.reindex_async
  end
end
