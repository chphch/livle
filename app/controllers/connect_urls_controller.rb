class ConnectUrlsController < ApplicationController
  before_action :authenticate_user!, only: [:describe]

  def index
    @nickname = user_signed_in? ? current_user.nickname : "손님???"
    render_by_device
  end

  def new
    if user_signed_in?
      @connectUrl = ConnectUrl.new(params.permit(:video_url))
      render_by_device
    else
      ############################ pop up sign_in modal
      redirect_to root_path
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
