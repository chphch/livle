class ChangeTemporaryUpcomingsArtistInfoToText < ActiveRecord::Migration[5.1]
  def change
    change_column :temporary_upcomings, :artist_info, :text
  end
end
