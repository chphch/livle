class UserMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views
  # def confirmation_instructions(record, token, opts={})
  #   super
  # end
  #
  # def reset_password_instructions(record, token, opts={})
  #   super
  # end
  #
  # def unlock_instructions(record, token, opts={})
  #   super
  # end

  # TODO: method를 추가한 후, registrations_controller#new에서 호출
  # def welcome_instructions(user)
  #   Devise::Mailer(to: user.email, subject: '라이블에 오신 것을 환영합니다!')
  # end
end