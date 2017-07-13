class ConnectUrlsController < ApplicationController
  def index
    @nickname = get_user_nickname
    render_by_device
  end

  def create
    render_by_device
  end

  private
    def get_user_nickname
      if user_signed_in?
        user_nickname = user_signed_in? ? current_user.nickname : ""
        return user_nickname
      else
        redirect_to '/mypage/index'
      end
    end
end
