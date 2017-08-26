class FeedsController < ApplicationController
  def index
    @officials = Feed.where(is_curation: true)
    @feeds = Feed.paginate(page: params[:page], per_page: 14)
    respond_to do |format|
      format.html { render_by_device }
      format.js { render 's_feed_' + device_suffix }
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
        if feed.feed.id != @feed.id
          @related_feeds.push(feed.feed)
        end
      end
    end
    # TODO: @related_feeds.shuffle.join
    # TODO: unique

    @like_true = user_signed_in? &&
        FeedLike.where(feed_id: params[:id], user_id: current_user.id).take
    @disable_nav = true
    render_by_device
  end

  def toggle_like
    if user_signed_in?
      if params[:player_id]
        playerFeedArtist = FeedArtist.find(params[:player_id])
        feed = playerFeedArtist.feed
        @player_id = playerFeedArtist.id
        @feed_id = feed.id
      else
        feed = Feed.find(params[:feed_id])
      end
      @like_true = FeedLike.toggle_like(feed, current_user)
      @like_type = "like"
      @like_count = feed.feed_likes.size
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
end
