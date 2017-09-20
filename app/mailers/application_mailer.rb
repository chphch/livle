class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@livle.co.kr"
  layout 'mailer'

  # TODO: registrations_controller#new에서 호출하는게 welcome을 보낼 위치 아닌가?
  def welcome_instructions(user)
    mail(to: user.email, subject: '라이블에 오신 것을 환영합니다!')
  end
end
