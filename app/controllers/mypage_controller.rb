class MypageController < ApplicationController
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

end
