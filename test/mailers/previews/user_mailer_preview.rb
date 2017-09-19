class UserMailerPreview < ActionMailer::Preview
  def welcome_instructions
    UserMailer.welcome_instructions(User.first)
  end
end