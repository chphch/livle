class ConvertDatabaseToUtf8mb4 < ActiveRecord::Migration[5.1]
  def change
    tables = ['feed_comments', 'feeds', 'notices', 'temporary_upcomings',
              'upcoming_comments', 'upcomings', 'users']

    tables.each do |table|
      execute "ALTER TABLE #{table} CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    end
  end
end
