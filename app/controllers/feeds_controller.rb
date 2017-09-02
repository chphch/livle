require 'will_paginate/array'
require 'iamport'

class FeedsController < ApplicationController
  include Iamport
  def index
    official_feeds = Feed.where(is_curation: true).order('created_at DESC')
    common_feeds = Feed.where(is_curation: false).order('created_at DESC')
    merged_feeds = common_feeds.each_slice(4).zip(official_feeds).flatten
    @feeds = merged_feeds.paginate(page: params[:page], per_page: 10) #for mobile

    @officials = official_feeds.paginate(page: params[:page], per_page: 4) #for desktop
    @commons = common_feeds.paginate(page: params[:page], per_page: 14) #for desktop
    @enable_transparent = true #for desktop

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

  def payment_test
    # Payment test view
  end

  def payment
    success = false
    msg = "결제 중 오류가 발생했습니다."

    # Validation
    if params['status'] == 'paid'
      pay_info = Iamport.payment(params[:imp_uid])["response"]
      if pay_info
        if pay_info['amount'] == params[:paid_amount].to_i
          @success = true
          msg = "결제에 성공했습니다."
          # Payment success
          # TODO : insert a ticket to the user model
        else
          # 결제 요청한 값과 실제 결제한 값이 다름
        end
      else
        msg = "잘못된 결제 아이디입니다."
      end
    end

    # 데스크탑에서는 json으로 ajax 콜백, 모바일에서는 리디렉션
    respond_to do |format|
      format.json { render json: {success: @success, msg: msg} }
      format.html
    end
  end
end
