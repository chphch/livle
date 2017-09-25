class ChangeUpcomingTicketUrlProvider < ActiveRecord::Migration[5.1]
  def up
    change_table :upcoming_ticket_urls do |t|
      t.change :provider, :integer
    end
    change_table :temporary_upcomings do |t|
      t.change :provider, :integer
    end
  end

  def down
    change_table :upcoming_ticket_urls do |t|
      t.change :provider, :string
    end
    change_table :temporary_upcomings do |t|
      t.change :provider, :string
    end
  end
end
