class MypageController < ApplicationController
  def index
    check_sign_in
  end

  def edit_profile
    check_sign_in
  end

  def settings
    check_sign_in
  end

  private
  def check_sign_in
    if not user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
