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

  def get_thumbnail_image(youtube_id)
    return "http://img.youtube.com/vi/#{youtube_id}/mqdefault.jpg"
  end

  def raw_text(text, class_method)
    context = text.gsub(/\n/, '<br />')
    puts "text: "+context
    result = '<p class="'+class_method+'">'+context+'</p>'
    return result.html_safe
  end
end
