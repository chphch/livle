class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session, if: ->{request.format.json?}

  # return the type of the device as a string
  def device_suffix
    browser.device.mobile? ? "mobile" : "desktop"
  end

  # render html or js file by respond format
  # also choose the template by the type of the requesting device
  def render_by_device
    def filename(device_suffix, filetype_suffix)
      "#{controller_name}/#{action_name}_#{device_suffix}.#{filetype_suffix}.erb"
    end

    respond_to do |format|
      format.html { render filename(device_suffix, "html"), layout: "/layouts/application_#{device_suffix}.html.erb" }
      format.js { render filename(device_suffix, "js") }
    end
  end

  # create or destroy like
  def create_like
    like_class = controller_name.classify.constantize          # e.g. CurationLike
    field_name = "#{controller_name.chomp('_likes')}_id"      # e.g. "curation_id"
    like = like_class.where("#{field_name} = ? AND user_id = ?", params[field_name.to_sym], current_user.id).take
    if like
      like.destroy
    else
      like = like_class.new
      like[field_name] = params[field_name.to_sym]
      like.user_id = current_user.id
      like.save
    end

    render "#{controller_name.chomp('_likes')}s/#{controller_name.chomp('s')}"
  end

  # keeping user to the same page after sign in
  def after_sign_in_path_for(resource)
    request.referrer
  end
end
