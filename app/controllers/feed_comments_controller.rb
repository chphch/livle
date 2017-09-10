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
    end
  end

  def destroy
    #TODO: 댓글 삭제기능 추가해야함!
  end
end
