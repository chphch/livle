class FeedArtistsController < ApplicationController

  def create
    if Artist.exists?(params[:artist_id])
      if FeedArtist.exists?(feed_id: params[:feed_id], artist_id: params[:artist_id])
        render text: 'Relation already exists'
      else
        fa = FeedArtist.new
        fa.feed_id = params[:feed_id]
        fa.artist_id = params[:artist_id]
        if fa.save
          redirect_back(fallback_location: root_path)
        else
          render text: 'Error saving feed_artist'
        end
      end
    else
      render text: 'Artist id not found'
    end
  end

  def destroy
    if FeedArtist.find(params[:id]).destroy
      redirect_back(fallback_location: root_path)
    else
      render text: 'Error destroying feed_artist'
    end
  end

end
