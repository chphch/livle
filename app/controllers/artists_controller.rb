class ArtistsController < ApplicationController
  before_action :is_admin, except: [:autocomplete]

  def new
    @artist = Artist.new
    render 'admin/artist_new_desktop'
  end

  def create
    @artist = Artist.new(image_url: params[:artist][:image_url], name: params[:artist][:name])
    if @artist.save
      redirect_to '/admin/artist'
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @artist = Artist.find(params[:id])
    if @artist.update(image_url: params[:artist][:image_url], name: params[:artist][:name])
      @message = "저장되었습니다"
      render '/xhrs/alert'
    else
      render text: @artist.errors.messages
    end
  end

  def destroy
    if Artist.destroy(params[:id])
      @message = "삭제되었습니다"
      render '/xhrs/alert'
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
