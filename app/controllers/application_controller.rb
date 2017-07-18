class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session, if: ->{request.format.json?}

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

  def create_like
    if user_signed_in?
      type = params[:type]                                       # e.g. "curation"
      like_class = "#{type.capitalize}Like".constantize          # e.g. CurationLike
      post_class = type.capitalize.constantize                   # e.g. Curation
      likes_field = "#{type}_likes"                              # e.g. "curation_likes"
      @like_true = like_class.create_like(type, current_user.id, params[:post_id])
      @like_count = post_class.find(params[:post_id]).send(likes_field).size
      render '/create_like'
    else
      render '/login_modal'
    end
  end

  # keeping user to the same page after sign in
  def after_sign_in_path_for(resource)
    request.referrer
  end

  private
  # return the type of the device as a string
  def device_suffix
    browser.device.mobile? ? "mobile" : "desktop"
  end
end
