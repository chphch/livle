class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    super
    render_by_device '/mypage/recover_password_new'
  end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
    render_by_device '/mypage/recover_password_edit'
  end

  # PUT /resource/password
  # def update
  #   super
  # end

  protected

  def after_resetting_password_path_for(resource)
    mypage_index_path
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
     mypage_recover_password_email_sent_path
  end
end