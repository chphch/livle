class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session, if: ->{request.format.json?}

  # render html or js file by respond format # also choose the template by the type of the requesting device
  def render_by_device(filename = nil, layout_name = "application")
    def fullname(device_suffix, filetype_suffix, filename)
      current_path = Rails.application.routes.recognize_path(request.path)[:controller]
      action_path = filename || "#{controller_name}/#{action_name}"
      if current_path[0..5] == 'users/'
        action_path = "devise/#{action_path}"
      end
      "#{action_path}_#{device_suffix}.#{filetype_suffix}.erb"
    end
    respond_to do |format|
      format.html { render fullname(device_suffix, "html", filename), layout: "/layouts/#{layout_name}_#{device_suffix}.html.erb" }
      format.js { render fullname(device_suffix, "js", filename) }
    end
  end

  def get_youtube_video_id(youtube_video_url)
    youtube_video_url.gsub(/https:\/\/www.youtube.com\/watch\?v=|https:\/\/youtu.be\//, '')
  end

  def host_name
    "http://localhost:3000"
  end

  # ####### handling facebook callback error
  # def after_sign_in_path_for(resource)
  #   if request.env['omniauth.origin']
  #     request.env['omniauth.origin']
  #   end
  # end

  private
  # return the type of the device as a string
  def device_suffix
    browser.device.mobile? ? "mobile" : "desktop"
  end
end
