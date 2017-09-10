class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  helper_method :resource_name, :resource, :devise_mapping, :resource_class

  # GET /users/sign_in
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

  # POST /users/sign_in
  def create
    user = User.where(email: params[:user][:email]).take
    if user && !user.confirmed_at
      # TODO 모달을 하든가 합시다
      render js: "$('#login-error-message').text('이메일 인증해주세요');"
      # 메일 인증 안된 경우 아래에서 401 status error 떠서 그전에 해줘야함
      # warden.authenticate 코드가 어디있는 메서드인지 못찾겠음
      return
    end

    self.resource = warden.authenticate(auth_options)
    if resource && resource.active_for_authentication?
      set_flash_message!(:notice, :signed_in)
      puts flash[:notice] #####TODO SUCCESSFUL LOGIN MESSAGE NEEDS TO BE PASSED TO RENDING PAGE
      sign_in(resource_name, resource)
      if params[:user][:remote_new_session] == 'true'
        res = "$('#login-modal').modal('hide');"
      else
        res = "window.location = '#{mypage_index_path}';"
      end
      respond_with resource do |format|
        format.js { render js: res }
      end
    else
      set_flash_message!(:alert, :not_found_in_database, {scope: "devise.failure"})
      render js: "$('#login-error-message').text('#{flash[:alert]}');"
    end
  end


  # DELETE /users/sign_out
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
