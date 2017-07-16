class UpcomingsController < ApplicationController
  require 'date'

  def index
    @upcomings = Upcoming.order('start_date ASC').paginate(page: params[:page], per_page: 8)
    calc_d_day
    respond_to do |format|
      format.html { render_by_device }
      format.js { render 'upcomings/s_upcoming_mobile' }
    end
  end

  def show
    @upcoming = Upcoming.find_by(id: params[:id])
    @d_day = d_day
    
    @disable_nav = true
    render_by_device
  end

  def share

  end

  private
    def calc_d_day
      @d_day = []
      @upcomings.each do |upcoming|
        start_day = upcoming.start_date.strftime('%Q').to_i
        today = DateTime.now.strftime('%Q').to_i
        day_to_millisec = 1000*60*60*24

        @d_day[upcoming.id] = ((start_day - today)/day_to_millisec).floor
      end
    end

    def d_day
      start_day = @upcoming.start_date.strftime('%Q').to_i
      today = DateTime.now.strftime('%Q').to_i
      day_to_millisec = 1000*60*60*24

      return ((start_day - today)/day_to_millisec).floor
    end
end
