class CurationsController < ApplicationController
  def show
    @curation = Curation.find_by(id: params[:id])
    @disable_nav = true
    render_by_device
  end
end
