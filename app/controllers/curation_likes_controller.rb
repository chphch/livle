class CurationLikesController < ApplicationController
  def create
   curationLike = CurationLike.where(curation_id: params[:curation_id], user_id: current_user.id).take
   puts curationLike
    if curationLike
      curationLike.destroy
    else
      curationLike = CurationLike.new
      curationLike.curation_id = params[:curation_id]
      curationLike.user_id = current_user.id
      curationLike.save
    end
    render 'curations/curation_like_mobile'
  end
end
