class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def increase_count_view
    self.count_view += 1
    self.save
  end

  def self.create_like(user, post_id)
    post_field = "#{self.name.downcase.chomp('like')}_id"   # e.g. "curation_id"
    like = self.where("#{post_field} = ? AND user_id = ?", post_id, user.id).take
    if like
      like.destroy
      return false
    else
      like = self.new
      like[post_field] = post_id
      like.user_id = user.id
      like.save
      return true
    end
  end

  def get_youtube_video_id(youtube_video_url)
    youtube_video_url.gsub(/https:\/\/www.youtube.com\/watch\?v=|https:\/\/youtu.be\//, '')
  end
end
