class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
  end

  def watch
    @feed = Feed.find_by(id: params[:feed_id])
  end

  private
    def req_latest_feeds

    end

    def share

    end
end
