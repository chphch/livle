class AdminController < ApplicationController
  def feed
    @feeds = Feed.all
    render_by_device
  end

  def artist
    @artists = Artist.all
    render_by_device
  end

  def upcoming
    @upcomings = Upcoming.all
    render_by_device
  end

  def temporary_upcoming
    @temp_upcomings = TemporaryUpcoming.all
    render_by_device
  end

  def connect
    @connects = ConnectUrl.all
    render_by_device
  end

  def user_list
    @users = User.all
    render_by_device
  end

  def data
    render_by_device
  end

  def notice
    @notices = Notice.all
    render_by_device
  end
end
