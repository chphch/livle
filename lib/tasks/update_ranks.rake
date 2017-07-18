namespace :update_ranks do
  desc 'update feed ranks'
  task feed_ranks: :environment do
    feeds = Feed.all
    today = DateTime.now.strftime('%Q').to_i
    six_hour_to_millisec = 1000*60*60*6

    feeds.each do |feed|
      sum = 40 * feed.feed_likes.size + 25 * Math.sqrt(feed.count_view)
      + 20 * feed.count_share + 15 * feed.feed_comments.size

      start_day = feed.created_at.strftime('%Q').to_i
      aging = 1 + Math.sqrt((today - start_day) / six_hour_to_millisec)

      result = sum / aging

      Feed.update(feed.id, rank: result) # Update rank value
    end
  end

  desc 'update curation ranks'
  task curation_ranks: :environment do
    curations = Curation.all
    today = DateTime.now.strftime('%Q').to_i
    six_hour_to_millisec = 1000*60*60*6

    curations.each do |curation|
      sum = 40 * curation.curation_likes.size + 25 * Math.sqrt(curation.count_view)
      + 20 * curation.count_share + 15 * curation.curation_comments.size

      start_day = curation.created_at.strftime('%Q').to_i
      aging = 1 + Math.sqrt((today - start_day) / six_hour_to_millisec)

      result = sum / aging

      Curation.update(curation.id, rank: result)
    end
  end
end