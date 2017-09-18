class ConnectUrlsController < ApplicationController
  before_action :authenticate_user!, only: [:describe]

  def index
    @nickname = user_signed_in? ? "#{current_user.nickname}님" : "당신"
    @bakckground_video_id = 'DSwd9Mng6uE' #for desktop
    @enable_transparent = true #for desktop
    @enable_footer = true #for desktop
    render_by_device
  end

  def new
    if user_signed_in?
      respond_to do |format|
        format.html {
          @connect_url = ConnectUrl.new
          @video_url = params[:video_url]
          @connect_feed = Feed.new(youtube_url: params[:video_url])
          @disable_nav = true #for mobile
          render_by_device
        }
      end
    else
      # 로그인 후 이용 가능하다는 모달이 없음..!
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
