class NoticesController < ApplicationController
  def index
    @notices = Notice.all
    render_by_device
  end
end
