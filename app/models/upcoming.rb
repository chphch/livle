class Upcoming < ApplicationRecord
  has_many :upcoming_likes
  has_many :upcoming_comments
  has_many :upcoming_artists

  def calc_d_day()
    return 12
  end
end
