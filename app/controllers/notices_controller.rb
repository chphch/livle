class NoticesController < ApplicationController
  def index
    @notices = Notice.all
    @disable_nav = true
    render_by_device
  end
end
