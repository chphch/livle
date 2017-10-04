class TicketController < ApplicationController
  def info
    @upcoming = Upcoming.find(params[:id])
    render_by_device
  end

  def book
    @upcoming = Upcoming.find(params[:id])
    render_by_device
  end
end
