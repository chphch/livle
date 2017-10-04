class TicketController < ApplicationController
  def info
    @upcoming = Upcoming.find(params[:id])
    @disable_background_image = true #for mobile
    render_by_device
  end

  def book
    @upcoming = Upcoming.find(params[:id])
    @disable_background_image = true #for mobile
    render_by_device
  end
end
