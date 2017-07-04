class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
  end

  def watch

  end

  private
    def req_latest_feeds

    end

    def share

    end
end
