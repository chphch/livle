class SearchController < ApplicationController
  def index
    @feeds = Feed.order('rank DESC').paginate(page: params[:page], per_page: 12)
    respond_to do |format|
      format.html { render_by_device }
      format.js { render 'search/s_search_mobile' }
    end
  end

  # keyword : feed.title, upcoming.title, artist.name, user.nickname, upcoming.place
  def result
    @search = params[:search]

    @feed_results = Searchkick.search(
      @search,
      fields: [:artists_names, :title, :user_nickname],
      operator: "or",
      match: :word_middle
    )
    @upcoming_results = Upcoming.search(
      @search,
      fields: [:artists_names, :title, :place],
      operator: "or",
      match: :word_middle
    )
    render_by_device
  end
end
