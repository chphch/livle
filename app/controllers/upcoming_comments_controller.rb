class UpcomingCommentsController < ApplicationController
  def create
    params.require(:upcoming_comment).permit(:content)
    if current_user
      @comment = UpcomingComment.new(content: params[:upcoming_comment][:content], upcoming_id: params[:upcoming_id]
                                     user_id: current_user.id)
      @comment.save
      respond_to do |format|
        format.js { render 'xhrs/append_comment_' + device_suffix }
      end
    end
  end

  def destroy
    uc = UpcomingComment.find(params[:id])
    if current_user && uc.user_id == current_user.id && uc.destroy
        redirect_back(fallback_location: root_path)
    end
  end
end
