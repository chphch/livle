class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session, if: ->{request.format.json?}

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
