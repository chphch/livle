class ConnectUrlsController < ApplicationController
  before_action :authenticate_user!, only: [:describe]

  def index
    @nickname = user_signed_in? ? current_user.nickname : "손님???"
    render_by_device
  end

  def new
    @video_url = params[:video_url]
    render_by_device

    @disable_nav = true
  end

  def create
    connectUrl = ConnectUrl.new(video_url: params[:video_url], describe: params[:describe], user_id: current_user.id)
    if connectUrl.save
      redirect_to connect_urls_path
    end
  end

  def destroy

  end
end
