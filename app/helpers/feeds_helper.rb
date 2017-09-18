module FeedsHelper
  def content_shorten(content)
    unless content
      return ""
    end

    marking = '<span style="color: #9BFFCC"> more..</span>'
    lines = content.split(/\n+/)
    if lines.size > 2
      if lines[0].length > 38
        m_content = lines[0][0..73] + marking
      elsif lines[1].length > 35
        m_content = lines[0] + "<br />" + lines[1][0..30] + marking
      else
        m_content = lines[0] + "<br />" + lines[1] + marking
      end

      puts "shorten: " + m_content
      return m_content
    else
      puts "original: " + content
      return content
    end
  end
end
