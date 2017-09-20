class ApplicationMailerPreview < ActionMailer::Preview
  # TODO: Add welcome mail
  def welcome_instructions
    ApplicationMailer.welcome_instructions(User.first)
  end
end