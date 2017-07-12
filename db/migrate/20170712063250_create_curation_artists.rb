class CreateCurationArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :curation_artists do |t|
      t.belongs_to :curation
      t.belongs_to :artist

      t.timestamps
    end
  end
end
