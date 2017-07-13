class CurationLikesController < ApplicationController
  def create
   curationLike = CurationLike.where(curation_id: params[:curation_id], user_id: current_user.id).take
    if curationLike

    else
#      curationLike = CurationLike.new
#      curationLike.curation_id = params[:curation_id]
#      curationLike.user_id = params[:curation_id]
#      curationLike.save
    end
  end
end
