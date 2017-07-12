class CreateConnectUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :connect_urls do |t|
      t.belongs_to :user
      t.belongs_to :feed
      t.string :video_url
      t.text :describe
      t.boolean :is_confirmed

      t.timestamps
    end
  end
end
