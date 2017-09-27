module FeedsHelper
  def content_shorten(content)
    unless content
      return ""
    end

    marking = '<span style="color: #dfdfdf;"> ..more</span>'
    lines = content.split(/\n+/)
    if lines.size > 2
      if lines[0].length > 38
        m_content = lines[0][0..73] + marking
      elsif lines[1].length > 35
        m_content = lines[0] + "<br />" + lines[1][0..30] + marking
      else
        m_content = lines[0] + "<br />" + lines[1] + marking
      end
      return m_content
    else
      return content
    end
  end

  def content_shorten_desktop(content)
    unless content
      return ""
    end

    marking = '<span style="color: #dfdfdf;"> ..more</span>'
    lines = content.split(/\n+/)

    base_lines = lines[0] + "<br />" + lines[1] + "<br />" + lines[2]
    if lines[1].length > 51
      lines[0] + "<br />" + lines[1][0..146] + marking
    elsif lines[2].length > 51
      m_content = lines[0] + "<br />" + lines[1] + "<br />" +
          lines[2][0..98] + marking
    elsif lines[3].length > 51
      m_content = base_lines + lines[3][0..48] + marking
    else
      m_content = base_lines + "<br />" + lines[3] + marking
    end

    return m_content
  end
end
