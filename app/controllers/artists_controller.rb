class ArtistsController < ApplicationController
  before_action :is_admin, only: [:update, :destroy]

  def update
    @artist = Artist.find(params[:id])
    if @artist.update(image_url: params[:artist][:image_url], name: params[:artist][:name])
      redirect_back(fallback_location: root_path)
    else
      render text: @artist.errors.messages
    end
  end

  def destroy
    if Artist.destroy(params[:id])
      redirect_back(fallback_location: root_path)
    else
      render text: @artist.errors.messages
    end
  end

  def autocomplete
    key = params[:key]
    result = Artist.select('id, name, image_url').where('name LIKE ?', "%#{key}%").limit(10)

    respond_to do |format|
      format.json { render json: result }
    end
  end
end
