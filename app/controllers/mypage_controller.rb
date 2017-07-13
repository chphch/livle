class MypageController < ApplicationController
  def index
    render_by_device
  end

  def edit_profile
    render_by_device
  end

  def settings
    render_by_device
  end

end
