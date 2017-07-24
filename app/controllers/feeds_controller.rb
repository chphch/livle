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
    @feed.increase_count_view
    @disable_nav = true
    render_by_device
  end

  def update
    @feed = Feed.find_by(id: params[:id])

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

  private
    def req_latest_feeds

    end

    def share

    end
end
