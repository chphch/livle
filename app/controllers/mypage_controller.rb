class MypageController < ApplicationController
  before_action :authenticate_user!, only: [:edit_password, :edit_profile, :settings]

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
end
