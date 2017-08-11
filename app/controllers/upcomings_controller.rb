class UpcomingsController < ApplicationController
  require 'date'

  def index
    today = DateTime.now
    @upcomings = Upcoming.where('start_date >= ?', today).order('start_date ASC')
                     .paginate(page: params[:page], per_page: 8)
    calc_d_day
    respond_to do |format|
      format.html { render_by_device }
      format.js { render 'upcomings/s_upcoming_mobile' }
    end
  end

  def show
    @upcoming = Upcoming.find(params[:id])
    @posts = @upcoming.posts
    @like_true = user_signed_in? &&
        UpcomingLike.where(
            upcoming_id: params[:id],
            user_id: current_user.id
        ).take
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
      d_day = ((start_day - today)/day_to_millisec).floor
      @d_day[upcoming.id] = -d_day
    end
  end
end
