class UpcomingArtist < ApplicationRecord
  belongs_to :upcoming
  belongs_to :artist
  after_commit :reindex_upcoming

  def reindex_upcoming
    upcoming.reindex_async
  end
end
