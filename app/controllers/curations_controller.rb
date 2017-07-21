class CurationsController < ApplicationController
  def show
    @curation = Curation.find_by(id: params[:id])
    @curation.increase_count_view
    @like_true = user_signed_in? ?
      CurationLike.where(curation_id: params[:id], user_id: current_user.id).take :
      false
    @disable_nav = true
    render_by_device
  end
end
