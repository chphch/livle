require 'will_paginate/array'

class FeedsController < ApplicationController
  before_action :is_admin, only: [:update, :destroy]

  def index
    # TODO : 30 is an arbitrary number, can be removed once the rank values get set
    official_feeds = Feed.where(is_curation: true).order('((rank + 30) * RAND()) DESC')
    common_feeds = Feed.where(is_curation: false).order('((rank + 30) * RAND()) DESC')
    merged_feeds = official_feeds.zip(common_feeds.each_slice(4)).flatten
    @feeds = merged_feeds.paginate(page: params[:page], per_page: 10) #for mobile

    @officials = official_feeds.paginate(page: params[:page], per_page: 6) #for desktop
    @commons = common_feeds.paginate(page: params[:page], per_page: 14) #for desktop
    @enable_transparent = true #for desktop
    @enable_footer = true #for desktop

    respond_to do |format|
      format.html { render_by_device }
      format.js { render 's_feed_' + device_suffix }
    end
  end

  def show
    @feed = Feed.find(params[:id])
    @feed.increment!(:count_view)
    @like_true = user_signed_in? &&
        FeedLike.where(feed_id: params[:id], user_id: current_user.id).take
    @disable_nav = true #for mobile
    @disable_background_image = true #for mobile
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
      redirect_to new_user_session_path
    end
  end

  def share
    # 로그인 체크 해야 하나 ?
    feed = Feed.find(params[:id])
    feed.increment!(:count_share)
    render json: feed.count_share
  end

  def update
    @feed = Feed.find(params[:id])
    if params[:feed][:title]
      action = @feed.update(title: params[:feed][:title], youtube_id: params[:feed][:youtube_id],
                            valuation: params[:feed][:valuation], is_curation: params[:feed][:is_curation])
      check_update(action, @feed)
    else
      action = @feed.update(is_curation: params[:feed][:is_curation])
      check_update(action, @feed)
    end
  end

  def destroy
    if Feed.destroy(params[:id])
      @message = "삭제되었습니다"
      render '/xhrs/alert'
    else
      render text: @feed.errors.messages
    end
  end

  private

  def check_update(update, feed)
    if update
      @message = "저장되었습니다"
      render '/xhrs/alert'
      # redirect_back(fallback_location: root_path)
    else
      render text: feed.errors.messages
    end
  end
end
