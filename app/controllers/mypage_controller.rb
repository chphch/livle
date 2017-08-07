class MypageController < ApplicationController
  before_action :authenticate_user!, only: [:edit_password, :edit_profile, :settings]
  helper_method :d_day

  def index
    render_by_device
  end

  def edit_password
    render_by_device
  end

  def edit_profile
    @disable_nav = true
    render_by_device
  end

  def update_profile
    @user = current_user

    puts @user.nickname
    if @user.update(profile_img: params[:profile_img])
      redirect_back(fallback_location: root_path)
    else
      render text: @user.errors.messages
    end
  end

  def settings
    @disable_nav = true
    render_by_device
  end

  def terms_of_use
    render_by_device
  end

  def privacy_policy
    render_by_device
  end

  def authenticate_user!
    if !user_signed_in?
      redirect_to mypage_index_path
    end
  end

  def d_day(start_date)
    start_day = start_date.strftime('%Q').to_i
    today = DateTime.now.strftime('%Q').to_i
    day_to_millisec = 1000*60*60*24

    d_day = ((start_day - today)/day_to_millisec).floor
    return -d_day
  end

  private
    def user_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
end
