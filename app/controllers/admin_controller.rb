require 'feed_status'
class AdminController < ApplicationController
  before_action :is_admin
  helper_method :get_feed_status, :set_feed_status

  def feed
    @official_feeds =  Feed.where(is_curation: true).order('rank DESC').paginate(page: params[:page], per_page: 30)
    @common_feeds = Feed.where(is_curation: false).order('rank DESC').paginate(page: params[:page], per_page: 30)
    @feed_status = FeedStatus.new #for remember status
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

  # helper
  def get_feed_status
    @feed_status.get_status
  end

  def set_feed_status(type)
    @feed_status.set_status(type)
  end
end
