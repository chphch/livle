class CurationsController < ApplicationController
  def watch
    @curation = Curation.find_by(id: params[:curation_id])
  end
end
