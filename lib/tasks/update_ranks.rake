namespace :update_ranks do
  desc 'update feed ranks'
  task feed_ranks: :environment do
    VIEW_WEIGHT = 1
    LIKE_WEIGHT = 20 * VIEW_WEIGHT
    COMMENT_WEIGHT = 7 * LIKE_WEIGHT
    SHARE_WEIGHT = 14 * LIKE_WEIGHT

    feeds = Feed.all

    feeds.each do |feed|
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

end

# TODO DB Backup ?
