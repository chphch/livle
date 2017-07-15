class SearchkickRecord < ApplicationRecord
  self.abstract_class = true
  searchkick callbacks: :async

  def search_data
    attributes.merge(artists_names: self.artists.map(&:name))
  end
end
