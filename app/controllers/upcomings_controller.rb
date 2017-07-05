class UpcomingsController < ApplicationController
  def index
    @Upcomings = Upcoming.all
  end

  def watch

  end

  private
    def share

    end

    def get_video(artist_name)

    end
end
