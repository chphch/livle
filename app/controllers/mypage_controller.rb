class MypageController < ApplicationController
  before_action :authenticate_user!, only: [:edit_password, :edit_profile, :settings]
  before_action :facebook_user!, only: [:edit_password]
  helper_method :d_day

  def index
    render_by_device
  end

  def edit_password
    if current_user.isFacebook?
      render_by_device('cannot_change_password')
    else
      render_by_device
    end
  end

  def recover_password_new
    render_by_device
  end

  def recover_password_email_sent
    render_by_device
  end

  def edit_profile
    @disable_nav = true
    render_by_device
  end

  def update_profile_img

  end

  def update_nickname
    current_user.nickname = params[:nickname]
    current_user.save
    render json: { nickname: params[:nickname] }
  end

  def update_introduce

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

  private

  def authenticate_user!
    if !user_signed_in?
      redirect_to mypage_index_path
    end
  end

  def facebook_user!
    if user_signed_in? && current_user.isFacebook?
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

  def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
