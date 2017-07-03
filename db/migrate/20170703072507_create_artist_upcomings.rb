class CreateArtistUpcomings < ActiveRecord::Migration[5.1]
  def change
    create_table :artist_upcomings do |t|
      t.belongs_to :upcoming
      t.belongs_to :artist

      t.timestamps
    end
  end
end
