class CreateUpcomingTicketUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :upcoming_ticket_urls do |t|
      t.belongs_to :upcoming
      t.string :provider
      t.string :ticket_url

      t.timestamps
    end
  end
end
