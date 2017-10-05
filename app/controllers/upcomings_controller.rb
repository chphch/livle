class UpcomingsController < ApplicationController
  before_action :is_admin, only: [:update, :destroy]

  def index
    today = DateTime.now
    @upcomings = Upcoming.where('end_date >= ?', today).order('start_date ASC')
                     .paginate(page: params[:page], per_page: 8)
    respond_to do |format|
      format.html { render_by_device }
      format.js { render 'upcomings/s_upcoming_'+device_suffix }
    end
  end

  def show
    @upcoming = Upcoming.find(params[:id])
    @artists = @upcoming.wrap_artists(current_user)
    @has_main_video = @upcoming.has_main_video
    if @has_main_video
      @main_video = @upcoming.main_video
      @main_video_image_url = Upcoming.main_video_image_url
    end
    @like_true = user_signed_in? &&
        UpcomingLike.where(upcoming_id: params[:id], user_id: current_user.id).take
    @disable_nav = true #for mobile
    @disable_background_image = true #for mobile
    render_by_device
  end

  def toggle_like
    if user_signed_in?
      upcoming = Upcoming.find(params[:upcoming_id])
      @like_true = UpcomingLike.toggle_like(upcoming, current_user)
      @like_type = "hand"
      @like_count = upcoming.upcoming_likes.size
      render '/xhrs/toggle_like'
    else
      redirect_to new_user_session_path
    end
  end

  def update
    @upcoming = Upcoming.find(params[:id])
    if @upcoming.update(title: params[:upcoming][:title], image_url: params[:upcoming][:image_url],
                        place: params[:upcoming][:place], main_youtube_id: params[:upcoming][:main_youtube_id],
                      start_date: params[:upcoming][:start_date], end_date: params[:upcoming][:end_date])
      @message = "저장되었습니다"
      render '/xhrs/alert'
    else
      render text: @upcoming.errors.messages
    end
  end

  def destroy
    if Upcoming.destroy(params[:id])
      @message = "삭제되었습니다"
      render '/xhrs/alert'
    else
      render text: @upcoming.errors.messages
    end
  end
end
