class MypageController < ApplicationController
  before_action :authenticate_user!, only: [:edit_password, :edit_profile, :settings]
  helper_method :d_day, :resource_name, :resource, :devise_mapping, :resource_class

  def index
    if user_signed_in?
      @title = current_user.nickname
      @like_size = current_user.feed_likes.size
      render_by_device
    else
      redirect_to new_user_session_path
    end
  end

  def edit_profile
    @title = current_user.nickname
    @disable_nav = true
    @back_url = request.referrer
    render_by_device
  end

  def update_profile
    user = current_user
    if user.update(profile_img: params[:profile_img], nickname: params[:nickname], intro: params[:intro])
      redirect_back(fallback_location: root_path)
    else
      render text: user.errors.messages
    end
  end

  def settings
    @disable_background_image = true
    @disable_nav = true
    @title = "설정"
    @back_url = mypage_index_path
    render_by_device
  end

  def terms_of_use
    @disable_nav = true
    @title = "약관"
    @back_url = mypage_settings_path
    render_by_device
  end

  def privacy_policy
    @disable_nav = true
    @title = "개인정보처리방침"
    @back_url = mypage_settings_path
    render_by_device
  end

  private

  def authenticate_user!
    unless user_signed_in?
      redirect_to mypage_index_path
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
