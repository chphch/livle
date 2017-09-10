class FeedComment < ApplicationRecord
  belongs_to :feed
  belongs_to :user

  def created_time
    created = (self.created_at.to_f*1000).to_i
    now = (Time.now.to_f*1000).to_i
    min_to_millisec = 1000*60

    term = (now - created)/min_to_millisec
    if term < 1
      return "방금전"
    elsif term > 59
      hour = term/60
      if hour < 24
        return hour.to_s+"시간 전"
      else
        return (hour/24).to_s+"일 전"
      end
    else
      return term.to_s+"분 전"
    end
  end
end
