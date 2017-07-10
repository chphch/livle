class MypageController < ApplicationController
  def index
  end

  def edit_profile
  end

  def settings
    if not user_signed_in?
      puts "NOT SINGED IN"
      puts
      redirect_to new_user_session
    end
    puts "SIGNED IN"
    puts
  end
end
