class CreateTemporaryUpcomings < ActiveRecord::Migration[5.1]
  def change
    create_table :temporary_upcomings do |t|
      t.string :title
      t.string :place
      t.date :start_date
      t.date :end_date
      t.string :provider
      t.string :ticket_url
      t.string :artist_info

      t.timestamps
    end
  end
end
