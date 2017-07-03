class CreateUpcomingArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :upcoming_artists do |t|
      t.belongs_to :upcoming
      t.belongs_to :artist

      t.timestamps
    end
  end
end
