class ArtistsController < ApplicationController
  def update
    @artist = Artist.find_by(id: params[:id])
    if @artist.update(image_url: params[:image_url], name: params[:name])
      redirect_back(fallback_location: root_path)
    else
      render text: @artist.errors.messages
    end
  end

  def delete
    if Artist.delete(params[:id])
      redirect_back(fallback_location: root_path)
    else
      render text: @artist.errors.messages
    end
  end
end
