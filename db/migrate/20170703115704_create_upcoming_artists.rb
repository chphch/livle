class CreateUpcomingArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :upcoming_artists do |t|

      t.timestamps
    end
  end
end
