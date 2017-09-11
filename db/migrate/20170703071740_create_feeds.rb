class CreateFeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :feeds do |t|
      t.belongs_to :user
      t.boolean :is_curation
      t.string :title
      t.string :youtube_url
      t.text :content
      t.integer :count_view
      t.integer :count_share
      t.float :rank
      t.integer :valuation

      t.timestamps
    end
  end
end
