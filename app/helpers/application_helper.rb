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

  def thumbnail_tag(youtube_url, options = {})
    video_id = get_youtube_video_id(youtube_url)
    # TODO : youtube-thumbnail 클래스에 인라인 스타일 옮기기
    return "<div
    class='youtube-thumbnail #{options[:class] if options[:class]}
    #{'loaded' if video_id.length == 0}'
    #{'id = ' + options[:id] if options[:id]}
    data-youtube-id='#{video_id}'
     style='
    width: 100%;
    height: 0;
    padding-bottom: 67%;
    background:url(\"#{asset_url('thumbnail_livle')}\") no-repeat center center;
    background-size: cover'></div>".html_safe
  end

  def raw_text(text, class_method)
    if text
      context = text.gsub(/\n/, '<br />')
      puts "text: "+context
      result = '<p class="'+class_method+'">'+context+'</p>'
      return result.html_safe
    end
  end

  # def get_thumbnail_from_url(youtube_video_url)
  #   get_thumbnail_from_id(get_youtube_video_id(youtube_video_url))
  # end

  def get_youtube_video_id(youtube_video_url)
    youtube_video_url ? youtube_video_url.gsub(/https:\/\/www.youtube.com\/watch\?v=|https:\/\/youtu.be\//, '') : ''
  end

  # def get_thumbnail_from_id(youtube_id)
  #   return get_best_thumbnail(youtube_id)
  # end
end
