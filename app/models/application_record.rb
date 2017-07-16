class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def increase_count_view
    self.count_view += 1
    self.save
  end

  def self.create_like(type, user_id, post_id)
    like = self.where("#{type}_id = ? AND user_id = ?",
                            post_id,
                            user_id,
                           ).take
    if like
      like.destroy
      return false
    else
      like = self.new
      like["#{type}_id"] = post_id
      like.user_id = user_id
      like.save
      return true
    end
  end
end
