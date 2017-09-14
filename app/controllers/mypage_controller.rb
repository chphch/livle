class MypageController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit_profile, :update_profile, :settings]

  def index
    @title = current_user.nickname
    @like_size = current_user.feed_likes.size
    @enable_footer = true #for desktop
    render_by_device
  end

  def about
    #회사 소개페이지를 위한 액션
    @enable_footer = true #for desktop
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
    params.require(:user).permit(:nickname, :profile_img, :introduce)
    if current_user.update(profile_img: params[:user][:profile_img], nickname: params[:user][:nickname],
                           introduce: params[:user][:introduce])
      @user = current_user
      render_by_device
    else
      puts current_user.errors.messages
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
    @title = "이용약관"
    @back_url = mypage_settings_path
    @enable_footer = true #for desktop
    render_by_device
  end

  def privacy_policy
    @disable_nav = true
    @title = "개인정보처리방침"
    @back_url = mypage_settings_path
    @enable_footer = true #for desktop
    render_by_device
  end

  private
  def authenticate_user!
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
