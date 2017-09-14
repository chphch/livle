module MypageHelper
  require 'clipboard'

  def copyEmail(email)
    Clipboard.copy(email)
  end

  def pasteEmail
    return Clipboard.paste
  end
end
