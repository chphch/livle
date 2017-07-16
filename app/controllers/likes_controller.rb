class LikesController < ApplicationController
  def create
    like_class = controller_name.classify.constantize          # e.g. CurationLike
    field_name = "#{controller_name.chomp('_likes')}_id"      # e.g. "curation_id"
    like = like_class.where("#{field_name} = ? AND user_id = ?", params[field_name.to_sym], current_user.id).take
    if like
      like.destroy
    else
      like = like_class.new
      like[field_name] = params[field_name.to_sym]
      like.user_id = current_user.id
      like.save
    end

    render "#{controller_name.chomp('_likes')}s/#{controller_name.chomp('s')}"
  end
end
