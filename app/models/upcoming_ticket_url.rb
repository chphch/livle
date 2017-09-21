class UpcomingTicketUrl < ApplicationRecord
  belongs_to :upcoming
  enum provider: [:interpark, :melon, :ticket_link]
end
