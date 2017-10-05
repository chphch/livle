class UpcomingArtistsController < ApplicationController
  before_action :is_admin

  def create
    if Artist.exists?(params[:artist_id])
      if UpcomingArtist.exists?(upcoming_id: params[:upcoming_id], artist_id: params[:artist_id])
        render text: 'Relation already exists'
      else
        ua = UpcomingArtist.new
        ua.upcoming_id = params[:upcoming_id]
        ua.artist_id = params[:artist_id]
        if ua.save
          redirect_back(fallback_location: root_path)
        else
          render text: 'Error saving upcoming_artist'
        end
      end
    else
      render text: 'Artist id not found'
    end
  end

  def destroy
    if UpcomingArtist.find(params[:id]).destroy
      @message = "삭제되었습니다"
      render '/xhrs/alert'
    else
      render text: 'Error destroying upcoming_artist'
    end
  end
end
