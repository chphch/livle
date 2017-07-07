class UpcomingsController < ApplicationController
  def index
    @upcomings = Upcoming.all
  end

  def watch
    @upcoming = Upcoming.find_by(id: params[:upcoming_id])
  end

  def share

  end

  def get_video(artist_name)

  end
end
