class SearchController < ApplicationController
  def index
    render_by_device
  end

  # keyword : feed.title, upcoming.title, artist.name, user.nickname, upcoming.place
  def search
    render_by_device
  end

end
