class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  helper_method :resource_name, :resource, :devise_mapping, :resource_class

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource)) do |format|
      format.html {
        @title = "로그인"
        resource.remote_new_session = false
        render_by_device
      }
      format.js {
        resource.remote_new_session = true
        render_by_device
      }
    end
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate(auth_options)
    if resource && resource.active_for_authentication?
      set_flash_message!(:notice, :signed_in)
      puts flash[:notice] #####TODO SUCCESSFUL LOGIN MESSAGE NEEDS TO BE PASSED TO RENDING PAGE
      sign_in(resource_name, resource)
      respond_with resource do |format|
        format.js {
          if params[:user][:remote_new_session] == "true"
            render js: "$('#login-modal').modal('hide');"
          elsif remote_new_session == "false"
            render js: "window.location = '#{mypage_index_path}';"
          end
        }
      end
    else
      set_flash_message!(:alert, :not_found_in_database, {scope: "devise.failure"})
      render js: "$('#login-error-message').text('#{flash[:alert]}');"
    end
  end


  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.

  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # def after_sign_in_path_for(resource)
  #   after_sign_in_path_for(resource)
  # end
end
