class CreateFeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :feeds do |t|
      t.belongs_to :user
      t.boolean :is_curation
      t.string :title
      t.string :youtube_url
      t.text :content
      t.integer :count_view, default: 0
      t.integer :count_share, default: 0
      t.float :rank, default: 0.0
      t.integer :valuation, default: 0

      t.timestamps
    end
  end
end
