class UpcomingsController < ApplicationController
  def index
    @upcomings = Upcoming.paginate(page: params[:page], per_page: 3)
    respond_to do |format|
      format.html
      format.js { render 'upcomings/s_upcoming' }
    end
  end

  def watch
    @upcoming = Upcoming.find_by(id: params[:upcoming_id])
  end

  def share

  end

  def get_video(artist_name)

  end
end
