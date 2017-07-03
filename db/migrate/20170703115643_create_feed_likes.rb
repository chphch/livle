class CreateFeedLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :feed_likes do |t|
      t.belongs_to :feed
      t.belongs_to :user

      t.timestamps
    end
  end
end
