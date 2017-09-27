module FeedsHelper
  def crop_lines(content, single_length, max_height)
    # content: 내용 / single_length: 한 줄에 들어가는 글자수 / max_height: 최대 줄 갯수
    lines = content.split(/\n+/)
    marking = '<span style="color: #dfdfdf;"> ..more</span>'
    sum_line_height = 0
    crop_result = ''

    lines.each do |line|
      cur_line_height = (line.length/single_length) + 1
      if sum_line_height + cur_line_height > max_height - 1
        crop_result +=
            line[0..(single_length*(max_height-sum_line_height)-5)] + marking
        break
      else
        sum_line_height += cur_line_height
        crop_result += line + "<br />"
      end
    end

    return crop_result
  end
end
