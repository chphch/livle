module FeedsHelper
  def content_shorten(content)
    lines = content.split(/\n+/)

    if lines.size > 2
      m_content = lines[0] + "<br />" + lines[1] + " ..."
      puts "shorten: " + m_content
      return m_content
    else
      puts "original: " + content
      return content
    end
  end
end
