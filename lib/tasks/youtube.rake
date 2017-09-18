gem 'google-api-client'
require 'google/apis/youtube_v3'

namespace :youtube do

  DEVELOPER_KEY = 'AIzaSyByx3Yhy-5WcZIYhZqY8OFIs4Hlqt1GRZ0'

  task status_check: :environment do

    Youtube = Google::Apis::YoutubeV3
    service = Youtube::YouTubeService.new
    service.key = DEVELOPER_KEY
    # K851vIUK37Q
    # k1PxcHNoTWI
    # Yr_7Bkj9eRI
    service.list_videos("snippet, content_details, statistics, status", id: "Yr_7Bkj9eRI") { |result, err|
      if result

        result.items.each do |i|
          puts "title"
          puts i.snippet.title

          puts "statistics"
          puts i.statistics.comment_count
          puts i.statistics.view_count

          puts "license"
          puts i.content_details.licensed_content

          puts "status"
          unless i.status.embeddable
            puts "Not embeddable"
          end
          puts i.status.license
          puts i.status.privacy_status
          puts i.status.failure_reason
          puts i.status.rejection_reason
          puts i.status.upload_status
        end

      else
        puts err
      end
    }

    #Feed.all.each do |f|
    #  youtube_id = f.youtube_url.split('/').last
    #end
  end

end
