namespace :livle_db do


  # TemporaryUpcomingsController의 update를 기반으로 했음
  # 해당 부분 코드 바뀌면 여기도 바꿔야 함
  def upcomingWithTemp(tu)
    uc = Upcoming.new
    uc.title = tu.title
    uc.place = tu.place
    uc.start_date = tu.start_date
    uc.end_date = tu.end_date
    uc.image_url = tu.image_url
    if uc.save
      return uc
    end
  end

  def linkArtist(upcoming, artist)
    ua = UpcomingArtist.new
    ua.upcoming_id = upcoming.id
    ua.artist_id = artist.id
    ua.save
  end

  task link_artists: :environment do

    TemporaryUpcoming.all.each do |tu|
      if Artist.exists?(name: tu.artist_info)
        artist = Artist.where(name: tu.artist_info).take
        uc = upcomingWithTemp(tu)
        if uc
          ticket = UpcomingTicketUrl.new
          ticket.upcoming_id = uc.id
          ticket.provider = tu.provider
          ticket.ticket_url = tu.ticket_url
          if ticket.save
            tu.destroy
            if linkArtist(uc, artist)
              puts "#{uc.title} : 업데이트 성공"
            else
              puts "#{uc.title} : Artist #{artist.name}을 연결하는 데 실패했습니다."
            end
          else
            puts "#{uc.title} : TicketUrl을 연결하는 데 실패했습니다. Temporary id : #{tu.id}"
          end
        else
          puts "#{tu.title} : Upcoming을 생성하는데 실패했습니다."
        end
      end
    end

  end


end
