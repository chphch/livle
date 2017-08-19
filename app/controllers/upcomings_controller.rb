class UpcomingsController < ApplicationController
  helper_method :d_day

  def index
    today = DateTime.now
    @upcomings = Upcoming.where('start_date >= ?', today).order('start_date ASC')
                     .paginate(page: params[:page], per_page: 8)
    respond_to do |format|
      format.html { render_by_device }
      format.js { render 'upcomings/s_upcoming_mobile' }
    end
  end

  def show
    @upcoming = Upcoming.find(params[:id])
    @posts = @upcoming.posts(current_user)
    @like_true = user_signed_in? &&
        UpcomingLike.where(
            upcoming_id: params[:id],
            user_id: current_user.id
        ).take
    @disable_nav = true
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
      render '/xhrs/login_modal'
    end
  end

  def toggle_video_like
    post_type = params[:post_class]
    post_id = params[:post_id]
    video_index = params[:video_index]
    if (post_type == "feed")
      puts "FEED LIKE"
      puts video_index
      redirect_to "/feeds/#{post_id}/toggle_like/#{video_index}"
    elsif (post_type == "curation")
      puts "CURATION LIKE"
      puts video_index
      redirect_to "/curations/#{post_id}/toggle_like/#{video_index}"
    end
  end

  def update
    @upcoming = Upcoming.find_by(id: params[:id])

    if @upcoming.update(title: params[:title], place: params[:place],
                        main_youtube_id: params[:main_youtube_id], ticket_url: params[:ticket_url])
      redirect_back(fallback_location: root_path)
    else
      render text: @upcoming.errors.messages
    end
  end

  def destroy
    if Upcoming.destroy(params[:id])
      redirect_back(fallback_location: root_path)
    else
      render text: @upcoming.errors.messages
    end
  end

  def d_day(start_date)
    start_day = start_date.strftime('%Q').to_i
    today = DateTime.now.strftime('%Q').to_i
    day_to_millisec = 1000*60*60*24

    d_day = ((start_day - today)/day_to_millisec).floor
    if d_day == 0
      return "-day"
    else
      return -d_day
    end
  end
end
