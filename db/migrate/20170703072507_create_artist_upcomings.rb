class CreateArtistUpcomings < ActiveRecord::Migration[5.1]
  def change
    create_table :artist_upcomings do |t|

      t.timestamps
    end
  end
end
