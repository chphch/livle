class CreateUpcomings < ActiveRecord::Migration[5.1]
  def change
    create_table :upcomings do |t|
      t.string :title
      t.string :place
      t.string :main_youtube_id
      t.date :start_date
      t.date :end_date
      t.string :ticket_url
      t.integer :count_view
      t.integer :count_share

      t.timestamps
    end
  end
end
