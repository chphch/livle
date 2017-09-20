require 'net/http'

module ApplicationHelper
  def resource_name
    :user
  end

  def resource_class
    User
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end


  def raw_text(text, class_method)
    context = text.gsub(/\n/, '<br />')
    puts "text: "+context
    result = '<p class="'+class_method+'">'+context+'</p>'
    return result.html_safe
  end

  def get_thumbnail_from_url(youtube_video_url)
    get_thumbnail_from_id(get_youtube_video_id(youtube_video_url))
  end

  def get_youtube_video_id(youtube_video_url)
    youtube_video_url ? youtube_video_url.gsub(/https:\/\/www.youtube.com\/watch\?v=|https:\/\/youtu.be\//, '') : ''
  end

  def get_thumbnail_from_id(youtube_id)
    return get_best_thumbnail(youtube_id)
  end

  private
  def get_best_thumbnail(youtube_id)
    url = "http://img.youtube.com/vi/#{youtube_id}/maxresdefault.jpg"
    get_response(url).class == Net::HTTPNotFound ? get_hq_thumbnail(youtube_id) : url
  end

  def get_hq_thumbnail(youtube_id)
    url = "http://img.youtube.com/vi/#{youtube_id}/hqdefault.jpg"
    get_response(url).class == Net::HTTPNotFound ? get_mq_thumbnail(youtube_id) : url
  end

  def get_mq_thumbnail(youtube_id)
    url = "http://img.youtube.com/vi/#{youtube_id}/mqdefault.jpg"
    get_response(url).class == Net::HTTPNotFound ? get_sd_thumbnail(youtube_id) : url
  end

  def get_sd_thumbnail(youtube_id)
    url = "http://img.youtube.com/vi/#{youtube_id}/sddefault.jpg"
    url
    # TODO placeholder 이미지 필요하게 되면 NotFound일 경우 그거 주고 아닐 경우 url 리턴하도록
    # get_response(url).class == Net::HTTPNotFound ? '' : url
  end

  def get_response(url)
    uri_parsed = URI.parse(url)
    req = Net::HTTP::Get.new(uri_parsed.to_s)
    Net::HTTP.start(uri_parsed.host, uri_parsed.port) {|http|
      http.request(req)
    }
  end
end
