module UpcomingsHelper
  def like_true(upcoming_id)
    if user_signed_in? &&
        UpcomingLike.where(upcoming_id: upcoming_id, user_id: current_user.id).take
      return true
    else
      return false
    end
  end
end
