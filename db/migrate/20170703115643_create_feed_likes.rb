class CreateFeedLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :feed_likes do |t|

      t.timestamps
    end
  end
end
