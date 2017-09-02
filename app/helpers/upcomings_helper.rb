module UpcomingsHelper
  def d_day(start_date)
    start_day = start_date.strftime('%Q').to_i
    today = DateTime.now.strftime('%Q').to_i
    day_to_millisec = 1000*60*60*24

    d_day = (start_day - today)/day_to_millisec
    if d_day == 0
      return "-day"
    else
      return -d_day
    end
  end

  def like_true(upcoming_id)
    if user_signed_in? &&
        UpcomingLike.where(upcoming_id: upcoming_id, user_id: current_user.id).take
      return true
    else
      return false
    end
  end
end
