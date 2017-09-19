class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    build_resource({})
    @disable_nav = true
    @title = "회원가입" #for mobile
    respond_with resource do |format|
      format.html { render_by_device }
    end
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.save
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        # TODO: send welcome mail
        # UserMailer.welcome_instructions(resource).deliver_now
        respond_with resource do |format|
          format.js { render "successful_signup_#{device_suffix}.js.erb" }
        end
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        render_by_device 'registrations/confirmation_email_sent'
        #respond_with resource do |format|
        #  format.js {render 'confirmation_email_sent_mobile' }
        #end
        #respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource do |format|
        format.js {
          if resource.errors.size != 0
            render js: "$('#error-message').text('#{resource.errors.messages.first.second.first}');"
          else
            render json: {} # unexpected authentication error
          end
        }
      end
    end
  end

  # GET /resource/edit
  def edit
    if current_user.isFacebook?
      render_by_device 'registrations/cannot_change_password'
    else
      @title = "비밀번호 변경"
      @back_url = mypage_settings_path
      render_by_device
    end
  end

  # PUT /resource
  # DON'T CONFUSE! only updating password, not profile. updating-profile is in mypage-controller at this time
  def update
    # TODO with blank password, current_user.update_with_password doesn't return false
    # temporarily add extra exception handling + (password error message doensn't contain "새로운")
    password_length = params[:user][:password].length
    if password_length != 0 && current_user.update_with_password(account_update_params)
      bypass_sign_in(current_user)
      # render 'registrations/update_password_success_mobile'
      render_by_device 'registrations/update_password_success'
    else
      if password_length == 0
        current_user.errors.messages[:password] << "새로운 " + I18n.t("activerecord.errors.models.user.attributes.password.blank")
      end
      render js: "$('#error-message').text('#{current_user.errors.messages.first.second.first}');"
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:current_password, :password, :password_confirmation])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    root_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
