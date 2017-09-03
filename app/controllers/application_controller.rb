class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session, if: ->{request.format.json?}

  # render html or js file by respond format # also choose the template by the type of the requesting device
  def render_by_device(filename = nil, args = {})
    args[:layout_name] ||= "application"
    respond_to do |format|
      format.html { render full_filename(device_suffix, "html", filename), layout: "/layouts/#{args[:layout_name]}_#{device_suffix}.html.erb" }
      format.js { render full_filename(device_suffix, "js", filename) }
    end
  end

  def host_name
    "http://localhost:3000"
  end

  private

  def full_filename(device_suffix, filetype_suffix, filename)
    action_path = filename || "#{controller_name}/#{action_name}"
    if request.path[0..5] == '/users'
      action_path = "devise/#{action_path}"
    end
    "#{action_path}_#{device_suffix}.#{filetype_suffix}.erb"
  end

  # return the type of the device as a string
  def device_suffix
    browser.device.mobile? ? "mobile" : "desktop"
  end
end
