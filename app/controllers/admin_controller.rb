class AdminController < ApplicationController
  before_action :is_admin

  def feed
    @feeds = Feed.order('rank DESC').paginate(page: params[:page], per_page: 30)
    render_by_device
  end

  def artist
    @artists = Artist.paginate(page: params[:page], per_page: 30)
    render_by_device
  end

  def upcoming
    @upcomings = Upcoming.order('rank DESC').paginate(page: params[:page], per_page: 30)
    render_by_device
  end

  def temporary_upcoming
    @temp_upcomings = TemporaryUpcoming.paginate(page: params[:page], per_page: 30)
    render_by_device
  end

  def connect
    @connects = ConnectUrl.paginate(page: params[:page], per_page: 30)
    render_by_device
  end

  def user_list
    @users = User.paginate(page: params[:page], per_page: 30)
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
