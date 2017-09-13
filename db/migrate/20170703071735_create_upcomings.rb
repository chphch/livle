class CreateUpcomings < ActiveRecord::Migration[5.1]
  def change
    create_table :upcomings do |t|
      t.string :title
      t.string :place
      t.string :main_youtube_url
      t.date :start_date
      t.date :end_date
      t.integer :count_view, default: 0
      t.integer :count_share, default: 0
      t.float :rank, default: 0.0

      t.timestamps
    end
  end
end
