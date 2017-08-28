class FeedCommentsController < ApplicationController
  def create
    @content = params[:content]
    @comment = FeedComment.new(content: @content, feed_id: params[:model_id],
                               user_id: params[:user_id])
    @comment.save

    respond_to do |format|
      format.js { render 'xhrs/append_comment_mobile' }
    end
  end
end
