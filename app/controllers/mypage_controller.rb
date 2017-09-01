class MypageController < ApplicationController
  before_action :authenticate_user!, only: [:edit_profile, :update_profile, :settings]

  def index
    if user_signed_in?
      @title = current_user.nickname
      @like_size = current_user.feed_likes.size
    end
    render_by_device
  end

  def edit_profile
    @title = current_user.nickname
    @disable_nav = true
    @back_url = request.referrer
    @user = current_user
    render_by_device
  end

  def update_profile
    # TODO: 이미지 저장이 안됨 (err: ERROR // PROFILE IS NOT UPDATED)
    params.require(:user).permit(:nickname, :profile_img, :introduce)
    if current_user.update(profile_img: params[:user][:profile_img], nickname: params[:user][:nickname],
                           introduce: params[:user][:introduce])
      @user = current_user
      render_by_device
    else
      render_by_device '/mypage/update_profile_error'
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
      redirect_to new_user_session_path
    end
  end
end
