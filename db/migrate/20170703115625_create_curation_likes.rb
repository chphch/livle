class CreateCurationLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :curation_likes do |t|
      t.belongs_to :curation
      t.belongs_to :user

      t.timestamps
    end
  end
end
