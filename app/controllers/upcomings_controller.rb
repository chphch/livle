class UpcomingsController < ApplicationController
  helper_method :d_day

  def index
    today = DateTime.now
    @upcomings = Upcoming.where('start_date >= ?', today).order('start_date ASC')
                     .paginate(page: params[:page], per_page: 8)
    respond_to do |format|
      format.html { render_by_device }
      format.js { render 'upcomings/s_upcoming_mobile' }
    end
  end

  def show
    @upcoming = Upcoming.find_by(id: params[:id])
    @upcoming.increase_count_view
    @like_true = user_signed_in? ?
      UpcomingLike.where(upcoming_id: params[:id], user_id: current_user.id).take :
      false
    @disable_nav = true
    render_by_device
  end

  def share

  end

  def d_day(start_date)
    start_day = start_date.strftime('%Q').to_i
    today = DateTime.now.strftime('%Q').to_i
    day_to_millisec = 1000*60*60*24

    d_day = ((start_day - today)/day_to_millisec).floor
    if d_day == 0
      return "-day"
    else
      return -d_day
    end
  end
end
