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

  def get_thumbnail_from_id(youtube_id)
    return "http://img.youtube.com/vi/#{youtube_id}/mqdefault.jpg"
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
end
