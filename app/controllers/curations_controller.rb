class CurationsController < ApplicationController
  def show
    @curation = Curation.find_by(id: params[:id])
    render_by_device
  end
end
