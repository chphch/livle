class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # render html or js file by respond format
  # also choose the template by the type of the requesting device
  def render_by_device
    device_suffix = browser.device.mobile? ? "mobile" : "desktop"
    def filename(device_suffix, filetype_suffix)
      "#{controller_name}/#{action_name}_#{device_suffix}.#{filetype_suffix}.erb"
    end

    respond_to do |format|
      format.html { render filename(device_suffix, "html"), layout: "/layouts/application_#{device_suffix}.html.erb" }
      format.js { render filename(device_suffix, "js") }
    end
  end
end
