class NoticesController < ApplicationController
  def index
    @notices = Notice.all
    @disable_background_image = true
    @disable_nav = true
    @title = "공지사항"
    @back_url = mypage_settings_path
    render_by_device
  end
end
