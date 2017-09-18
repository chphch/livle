class FeedCommentsController < ApplicationController
  def create
    params.require(:feed_comment).permit(:content)
    if current_user
      @comment = FeedComment.new(content: params[:feed_comment][:content], feed_id: params[:feed_id],
                                 user_id: current_user.id)
      @comment.save
      respond_to do |format|
        format.js { render 'xhrs/append_comment_' + device_suffix }
      end
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    fc = FeedComment.find(params[:id])
    if current_user && fc.user_id == current_user.id && fc.destroy
        redirect_back(fallback_location: root_path)
    end
  end
end
