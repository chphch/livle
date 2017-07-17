class ConnectUrlsController < ApplicationController
  before_action :authenticate_user!, only: [:describe]

  def index
    @nickname = user_signed_in? ? current_user.nickname : "손님???"
    render_by_device
  end

  def new
    @connectUrl = ConnectUrl.new(video_url: params[:video_url])
    respond_to do |format|
      format.html { render_by_device }
      format.js { render 'partial_views/video_player' }
    end
  end

  def create
    connectUrl = ConnectUrl.new(params.require(:connect_url).permit(:video_url, :describe))
    connectUrl.user_id = current_user.id
    connectUrl.save
    redirect_to connect_urls_path
  end

  def destroy

  end
end
