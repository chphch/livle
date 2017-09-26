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

  def merge #move to feed
    connect = ConnectUrl.find(params[:id])
    new_feed = Feed.new
    new_feed_artist = FeedArtist.new

    new_feed.user = connect.user
    new_feed.youtube_url = connect.video_url
    new_feed.content = connect.describe
    new_feed.title = params[:feed_title]
    new_feed_artist.feed = new_feed
    new_feed_artist.artist = Artist.find_by(name: params[:feed_artist])

    if new_feed.save && new_feed_artist.save
      connect.update(feed: new_feed, is_confirmed: true)
    end
  end

  def destroy

  end

  private
  def connect_url_params
    params.require(:connect_url).permit(:video_url, :describe)
  end
end
