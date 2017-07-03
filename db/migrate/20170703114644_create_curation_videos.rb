class CreateCurationVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :curation_videos do |t|
      t.belongs_to :curation
      t.belongs_to :artist
      t.string :youtube_id

      t.timestamps
    end
  end
end
