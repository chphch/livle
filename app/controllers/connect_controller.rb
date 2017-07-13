class ConnectController < ApplicationController
  def index
    # url 입력 & submit -> recommended_urls#create로 전송
    render_by_device
  end
end
