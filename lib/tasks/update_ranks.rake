namespace :update_ranks do
  desc 'update feed ranks'
  task feed_ranks: :environment do
    VIEW_WEIGHT = 1
    LIKE_WEIGHT = 20 * VIEW_WEIGHT
    COMMENT_WEIGHT = 7 * LIKE_WEIGHT
    SHARE_WEIGHT = 14 * LIKE_WEIGHT

    ARBITRARY_WEIGHT = 1400 # 코멘트 10개 = 검수자 1점

    Feed.all.each do |feed|

      priority = VIEW_WEIGHT * feed.count_view + SHARE_WEIGHT * feed.count_share + COMMENT_WEIGHT * feed.feed_comments.size

      feed.feed_likes.each do |like|
        priority = priority + time_coefficient(like.created_at) * LIKE_WEIGHT
      end

      feed.feed_comments.each do |comment|
        priority = priority + time_coefficient(comment.created_at) * COMMENT_WEIGHT
      end

      Feed.update(feed.id, rank: priority) # Update rank value

    end

  end


  # TODO later : elaborate
  def time_coefficient(created_at)
    lower_bound = 0.05
    oldest_created_at = Feed.minimum(:created_at)
    normalized = ( created_at - oldest_created_at ) / (Time.now - oldest_created_at)
    [1 - Math.sqrt(normalized), lower_bound].max
  end

  desc 'update upcoming ranks'
  task upcoming_ranks: :environment do
    # 3개의 +1점짜리 영상(관련 영상에 달린 코멘트가 30개) = 하루
    RECENCY_WEIGHT = 4200

    Upcoming.all.each do |upcoming|

      popularity = 0

      upcoming.artists.each do |artist|
        artist.feeds.each do |feed|
          popularity = popularity + feed.rank
        end
      end

      today = Time.now.to_date

      if upcoming.end_date < today # 종료된 공연
        d_day = -100
      else
        d_day = upcoming.start_date - today
        if d_day < 0
          d_day = 0
        end
      end

      result = popularity - d_day * RECENCY_WEIGHT

      Upcoming.update(upcoming.id, rank: priority)

    end

  end

end

# TODO DB Backup ?
