class ConnectUrlsController < ApplicationController
  before_action :authenticate_user!, only: [:describe]

  def index
    @nickname = user_signed_in? ? "#{current_user.nickname}님" : "당신"
#    @bakckground_video_id = 'DSwd9Mng6uE' #for desktop
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
    if current_user
      connectUrl = ConnectUrl.new(connect_url_params)
      connectUrl.user_id = current_user.id
      connectUrl.save
      render_by_device
    end
  end

  def merge #for Admin
    connect = ConnectUrl.find(params[:id])
    new_feed = Feed.new
    new_feed_artist = FeedArtist.new

    new_feed.user = connect.user
    new_feed.youtube_url = connect.video_url
    new_feed.content = connect.describe
    new_feed.title = params[:feed_title]
    new_feed_artist.feed = new_feed
    new_feed_artist.artist = Artist.find_by(name: params[:feed_artist])

    if new_feed.save
      if new_feed_artist.artist
        new_feed_artist.save
        connect.update(feed: new_feed, is_confirmed: true)
        redirect_back(fallback_location: root_path)
      else
        render text: "해당 이름을 가진 Artist를 찾지 못했습니다."
      end
    else
      render text: "Feed로 보내는데 실패했습니다."
    end
  end

  def destroy #for Admin
    connect = ConnectUrl.find(params[:id])
    if connect.feed.destroy && connect.destroy
      redirect_back(fallback_location: root_path)
    else
      render text: "Connect를 삭제하는데 실패했습니다."
    end
  end

  private
  def connect_url_params
    params.require(:connect_url).permit(:video_url, :describe)
  end
end
