class FeedCommentsController < ApplicationController
  def create
    params.require(:feed_comment).permit(:content, :model_id, :user_id)
    if params[:feed_comment][:user_id] != -1
      @comment = FeedComment.new(content: params[:feed_comment][:content], feed_id: params[:feed_comment][:model_id],
                                 user_id: params[:feed_comment][:user_id])
      @comment.save
      respond_to do |format|
        format.js { render 'xhrs/append_comment_' + device_suffix }
      end
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    FeedComment.find(params[:id]).destroy
    # TODO: FeedComment 객체만 삭제하면 Feed, User 모델에서 reindex 문제는 없을까?
    redirect_back(fallback_location: root_path)
  end
end
