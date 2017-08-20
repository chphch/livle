class FeedsController < ApplicationController
  helper_method :content_shorten

  def index
    @curations = Curation.paginate(page: params[:page], per_page: 3)
    @feeds = Feed.paginate(page: params[:page], per_page: 8)
    respond_to do |format|
      format.html { render_by_device }
      format.js { render 'feeds/s_feed_mobile' }
    end
  end

  def show
    @feed = Feed.find(params[:id])
    @feed.increase_count_view
    @video_id = @feed.video_id

    @related_feeds = []
    @feed.artists.each do |artist|
      same_artist = Artist.find(artist.id)
      same_artist.feed_artists.each do |feed|
        @related_feeds.push(feed.feed)
      end
    end

    @like_true = user_signed_in? &&
        FeedLike.where(feed_id: params[:id], user_id: current_user.id).take
    @disable_nav = true
    render_by_device
  end

  def toggle_like
    if user_signed_in?
      feed = Feed.find(params[:feed_id])
      @like_true = FeedLike.toggle_like(feed, current_user)
      @like_type = "like"
      @like_count = feed.feed_likes.size
      @video_index = params[:video_index] || 0
      render '/xhrs/toggle_like'
    else
      render '/xhrs/login_modal'
    end
  end

  def update
    @feed = Feed.find(params[:id])
    if @feed.update(title: params[:title], youtube_id: params[:youtube_id])
      redirect_back(fallback_location: root_path)
    else
      render text: @feed.errors.messages
    end
  end

  def destroy
    if Feed.destroy(params[:id])
      redirect_back(fallback_location: root_path)
    else
      render text: @feed.errors.messages
    end
  end

  def content_shorten(content)
    lines = content.split(/\n/)

    if lines.size > 2
      m_content = lines[0] + "<br />" + lines[1] + " ..."
      puts "shorten: " + m_content
      return m_content
    else
      puts "original: " + content
      return content
    end
  end
end
