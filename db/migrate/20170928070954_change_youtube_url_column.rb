class ChangeYoutubeUrlColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :connect_urls, :video_url, :youtube_id
    rename_column :feeds, :youtube_url, :youtube_id
    rename_column :upcomings, :main_youtube_url, :main_youtube_id
  end
end
