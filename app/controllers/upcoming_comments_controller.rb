class UpcomingCommentsController < ApplicationController
  def create
    @content = params[:content]
    @comment = UpcomingComment.new(content: @content, upcoming_id: params[:model_id],
                                   user_id: params[:user_id])
    @comment.save

    respond_to do |format|
      format.js { render 'xhrs/append_comment_mobile' }
    end
  end
end
