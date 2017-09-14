class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.belongs_to :curation
      t.belongs_to :artist
      t.string :name
      t.string :alternative_name
      t.string :image_url

      t.timestamps
    end
  end
end
