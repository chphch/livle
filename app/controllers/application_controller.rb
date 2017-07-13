class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def render_by_device
    if browser.device.mobile?
      render controller_name + "/" + action_name + "_mobile.html.erb",
        layout: '/layouts/application_mobile.html.erb'
    else
      render controller_name + "/" + action_name + "_desktop.html.erb",
        layout: '/layouts/application_desktop.html.erb'
    end
  end
end
