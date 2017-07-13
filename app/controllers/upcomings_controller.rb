class UpcomingsController < ApplicationController
  def index
    @upcomings = Upcoming.paginate(page: params[:page], per_page: 8)
    respond_to do |format|
      format.html
      format.js { render 'upcomings/s_upcoming_mobile' }
    end
    render_by_device
  end

  def show
    @upcoming = Upcoming.find_by(id: params[:id])
    render_by_device
  end

  def share

  end

  def get_video(artist_name)

  end
end
