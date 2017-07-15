class ArtistsRecord < ApplicationRecord
  self.abstract_class = true
  def search_data
    #attributes.merge(artists_names: self.artists.map { |artist| artist.name }
    attributes.merge(artists_names: self.artists.map(&:name))
  end
end
