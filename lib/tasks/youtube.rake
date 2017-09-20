gem 'google-api-client'
require 'google/apis/youtube_v3'
require 'csv'

namespace :youtube do

  DEVELOPER_KEY = 'AIzaSyByx3Yhy-5WcZIYhZqY8OFIs4Hlqt1GRZ0'
  Youtube = Google::Apis::YoutubeV3
  service = Youtube::YouTubeService.new
  service.key = DEVELOPER_KEY

  task initial_weight: :environment do

    count = 0
    err_count = 0

    Feed.all.each do |f|
      youtube_id = f.youtube_url.split('/').last
      service.list_videos("statistics", id: youtube_id) { |result, err|
        if result
          result.items.each do |i|
            view_cnt = i.statistics.view_count
            if view_cnt >= 1000000
              f.update(valuation: 4)
            elsif view_cnt >= 100000
              f.update(valuation: 3)
            elsif view_cnt >= 10000
              f.update(valuation: 2)
            else
              f.update(valuation: 1)
            end
          end
        else
          puts err
          err_count = err_count + 1
        end
      }
      count = count + 1
      puts "#{count} processed"
    end

    puts "Completed #{count} items with #{err_count} errors"
  end

  task prune: :environment do
    file_loc = '/Users/js/livle_prune.csv'
    log = CSV.open(file_loc, 'a')
    removal_count = 0
    count = 0
    err_count = 0

    log.puts ["deleted_at", "reason", "id", "user_id", "is_curation", "title",
      "youtube_url", "content", "count_view", "count_share", "rank",
      "valuation", "created_at", "updated_at",
      "feed_artists", "feed_likes", "feed_comments", "connect_urls"]

    Feed.all.each do |f|
      youtube_id = f.youtube_url.split('/').last
      service.list_videos("status", id: youtube_id) { |result, err|
        if result
          result.items.each do |i|
            unless i.status.embeddable
              log.puts [ DateTime.now, "not embeddable", f.id, f.user_id, f.is_curation, f.title,
                f.youtube_url, f.content, f.count_view, f.count_share, f.rank,
                f.valuation, f.created_at, f.updated_at,
                f.feed_artists.size, f.feed_likes.size, f.feed_comments.size, f.connect_urls.size ]
              if f.destroy
                puts "Destroyed"
                removal_count = removal_count + 1
              else
                puts "ERROR while destroying"
              end
            end
          end
        else
          puts err
          err_count = err_count + 1
        end
      }

      count = count + 1
      puts "#{count} processed"
    end

    log.close
    print "#{removal_count} records removed, with #{err_count} errors"

  end

  task status_check: :environment do

    # K851vIUK37Q : 정상 재생
    # k1PxcHNoTWI : Not embeddable
    # Yr_7Bkj9eRI : 저작권 상의 이유로 차단
    view_file = CSV.open('/Users/js/livle_view.csv', 'a')
    like_file = CSV.open('/Users/js/livle_like.csv', 'a')
    comment_file = CSV.open('/Users/js/livle_comment.csv', 'a')
    not_embeddable_count = 0
    err_count = 0
    count = 0

    Feed.all.each do |f|
      youtube_id = f.youtube_url.split('/').last
      service.list_videos("statistics, status", id: youtube_id) { |result, err|
        if result
          result.items.each do |i|
            #puts i.snippet.title
            view_file.puts [ i.statistics.view_count ]
            like_file.puts [ i.statistics.like_count ]
            comment_file.puts [ i.statistics.comment_count ]
            unless i.status.embeddable
              not_embeddable_count = not_embeddable_count + 1
            end
          end
        else
          puts err
          err_count = err_count + 1
        end
      }
      count = count + 1
      puts "#{count} processed"
    end

    view_file.close
    like_file.close
    comment_file.close

    print "Completed with #{not_embeddable_count} unembeddables and #{err_count} errors"
  end

end
