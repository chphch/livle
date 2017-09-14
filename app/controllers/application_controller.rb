class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session, if: ->{request.format.json?}

  # render html or js file by respond format # also choose the template by the type of the requesting device
  def render_by_device(filename = nil, args = {})
    args[:layout_name] ||= "application"
    render full_filename(filename, args), layout: full_layoutname(args)
  end

  def host_name
    "http://localhost:3000"
  end


  protected

  # return the type of the device as a string
  def device_suffix
    browser.device.mobile? ? "mobile" : "desktop"
  end

  # return the rendering filetype as a string
  def filetype_suffix(args)
    if args[:format]
      return args[:format]
    elsif request.xhr?.present?
      return "js"
    else
      return "html"
    end
  end

  private

  def full_filename(filename, args)
    action_path = filename || "#{controller_name}/#{action_name}"
    if request.path[0..5] == '/users'
      action_path = "devise/#{action_path}"
    end
    "#{action_path}_#{device_suffix}.#{filetype_suffix(args)}.erb"
  end

  def full_layoutname(args)
    if request.xhr?.present? || args[:format] == :js
      return nil
    else
      return "/layouts/#{args[:layout_name].to_s}_#{device_suffix}.html.erb"
    end
  end

  def is_admin
    unless current_user && current_user.is_admin
      render html: "권한이 없습니다."
    end
  end

end
