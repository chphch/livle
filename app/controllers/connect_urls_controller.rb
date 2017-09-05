class ConnectUrlsController < ApplicationController
  before_action :authenticate_user!, only: [:describe]

  def index
    @nickname = user_signed_in? ? "#{current_user.nickname}님" : "당신"
    @enable_transparent = true #for desktop

    render_by_device
  end

  def new
    if user_signed_in?
      respond_to do |format|
        format.html {
          @connect_url = ConnectUrl.new
          @video_url = params[:video_url]
          @connect_feed = Feed.new(youtube_url: params[:video_url])
          @disable_nav = true
          render_by_device
        }
        format.js { render js: "window.location = '#{new_connect_url_path}?video_url=#{params[:video_url]}';" }
      end
    else
      redirect_to new_user_session_path
    end
  end

  def create
    connectUrl = ConnectUrl.new(connect_url_params)
    connectUrl.save
    render_by_device
  end

  def destroy

  end

  private
  def connect_url_params
    params.require(:connect_url).permit(:video_url, :describe, :user_id)
  end
end
