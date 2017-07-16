class MypageController < ApplicationController
  before_action :authenticate_user!, only: [:edit_profile, :settings]

  def index
    render_by_device
  end

  def edit_profile
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
    render_by_device
  end

  def authenticate_user!
    if !user_signed_in?
      redirect_to mypage_index_path
    end
  end
end
