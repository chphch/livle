class CreateCurationLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :curation_likes do |t|

      t.timestamps
    end
  end
end
