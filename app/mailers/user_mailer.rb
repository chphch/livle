class UserMailer < ApplicationMailer
  def welcome_instructions(user)
    mail(to: user.email, subject: '라이블에 오신 것을 환영합니다!')
  end
end