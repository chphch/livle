require 'will_paginate/array'

class FeedsController < ApplicationController
  def index
    official_feeds = Feed.where(is_curation: true).order('created_at DESC')
    common_feeds = Feed.where(is_curation: false).order('created_at DESC')
    merged_feeds = common_feeds.each_slice(4).zip(official_feeds).flatten
    @feeds = merged_feeds.paginate(page: params[:page], per_page: 10) #for mobile

    @officials = official_feeds.paginate(page: params[:page], per_page: 4) #for desktop
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
    @feed.increase_count_view
    @related_feeds = @feed.related_feeds
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
      redirect_to new_user_session_path
    end
  end

  def update
    @feed = Feed.find(params[:id])
    if @feed.update(title: params[:title], youtube_url: params[:youtube_url])
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
