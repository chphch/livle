class UpcomingComment < ApplicationRecord
  belongs_to :upcoming
  belongs_to :user
  attr_accessor :created_at

  def created_time
    created = (@created_at.to_f*1000).to_i
    now = (Time.now.to_f*1000).to_i
    min_to_millisec = 1000*60

    term = (now - created)/min_to_millisec
    if term < 1
      return "방금전"
    elsif term > 59
      hour = term/60
      if hour < 24
        return hour.to_s+"h"
      else
        return (hour/24).to_s+"일"
      end
    else
      return term.to_s+"m"
    end
  end
end
