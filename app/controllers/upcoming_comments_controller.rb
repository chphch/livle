class UpcomingCommentsController < ApplicationController
  def create
    params.require(:upcoming_comment).permit(:content, :model_id, :user_id)
    if params[:upcoming_comment][:user_id] != -1
      @comment = UpcomingComment.new(content: params[:upcoming_comment][:content], upcoming_id: params[:upcoming_comment][:model_id],
                                     user_id: params[:upcoming_comment][:user_id])
      @comment.save
      respond_to do |format|
        format.js { render 'xhrs/append_comment_' + device_suffix }
      end
    end
  end

  def destroy
    UpcomingComment.find(params[:id]).destroy
    # TODO: FeedComment 객체만 삭제하면 Feed, User 모델에서 reindex 문제는 없을까?
    redirect_back(fallback_location: root_path)
  end
end
