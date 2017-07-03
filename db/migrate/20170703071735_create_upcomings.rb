class CreateUpcomings < ActiveRecord::Migration[5.1]
  def change
    create_table :upcomings do |t|
      t.string :title
      # text -> youtube_id array
      t.text :youtube_ids
      t.string :place
      t.date :start_date
      t.date :end_date
      t.string :ticket_url
      t.integer :count_view
      t.integer :count_share

      t.timestamps
    end
  end
end
