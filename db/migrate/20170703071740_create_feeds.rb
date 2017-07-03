class CreateFeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :feeds do |t|
      t.belongs_to :user
      t.string :title
      t.string :youtube_id
      t.integer :count_view
      t.integer :count_share
      t.boolean :is_user

      t.timestamps
    end
  end
end
