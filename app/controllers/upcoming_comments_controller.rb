class UpcomingCommentsController < ApplicationController
  def create
    params.require(:upcoming_comment).permit(:content, :model_id, :user_id)
    if params[:upcoming_comment][:user_id] != -1
      @comment = UpcomingComment.new(content: params[:upcoming_comment][:content], upcoming_id: params[:upcoming_comment][:model_id],
                                     user_id: params[:upcoming_comment][:user_id])
      @comment.save
      @content = @comment.content
      @user = User.find(@comment.user_id)
      respond_to do |format|
        format.js { render 'xhrs/append_comment_mobile' }
      end
    end
  end
end
