class CreateFeedArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :feed_artists do |t|

      t.timestamps
    end
  end
end
