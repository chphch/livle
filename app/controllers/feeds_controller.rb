class FeedsController < ApplicationController
  def index
    @curations = Curation.paginate(page: params[:page], per_page: 3)
    @feeds = Feed.paginate(page: params[:page], per_page: 6)
    respond_to do |format|
      format.html { render_by_device }
      format.js { render 'feeds/s_feed_mobile' }
    end
  end

  def show
    @feed = Feed.find_by(id: params[:id])
    render_by_device
  end

  private
    def req_latest_feeds

    end

    def share

    end
end
