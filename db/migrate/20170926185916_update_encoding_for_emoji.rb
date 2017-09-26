class UpdateEncodingForEmoji < ActiveRecord::Migration[5.1]
  def change
    # for each table
    tables = ['feeds', 'feed_comments', 'notices', 'recent_keywords', 'temporary_upcomings',
              'upcoming_comments', 'upcomings', 'users']
    tables.each do |table|
      execute "ALTER TABLE #{table} CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    end

    execute "ALTER TABLE 'connect_urls' CHANGE 'describe' VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE 'feed_comments' CHANGE 'content' VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE 'notices' CHANGE 'content' VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE 'temporary_upcomings' CHANGE 'artist_info' VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE 'upcoming_comments' CHANGE 'content' VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE 'users' CHANGE 'introduce' VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
  end
end
