class CreateCurationVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :curation_videos do |t|

      t.timestamps
    end
  end
end
