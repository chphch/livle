module MypageHelper
  require 'clipboard'

  def copyEmail(email)
    Clipboard.copy(email)
    puts "Email copied: " + email
  end

  def pasteEmail
    return Clipboard.paste
  end
end
