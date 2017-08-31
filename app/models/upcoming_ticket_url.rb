class UpcomingTicketUrl < ApplicationRecord
  belongs_to :upcoming
  class << self; attr_accessor :providers end
  @providers = ["interpark", "auction", "ticketbay"]

end
