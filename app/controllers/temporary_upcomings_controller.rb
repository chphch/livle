class TemporaryUpcomingsController < ApplicationController
  before_action :is_admin, except: [:create]

  def destroy_all
    TemporaryUpcoming.destroy_all
    redirect_back(fallback_location: root_path)
  end

  def create
    title = params[:title]
    place = params[:place]
    start_date = params[:start_date] #yyyy-mm-dd hh:mm:ss OR yyyy-mm-dd
    end_date = params[:end_date]
    image_url = params[:image_url]
    provider = params[:provider]
    ticket_url = params[:ticket_url]
    artist_info = params[:artist_info]
    key = params[:key]

    # Input validation
    unless key == "livlecreatingtempupcoming"
      render status: 403, json: {success: false, msg: "Unauthorized key"}
      return
    end
    if !title || !start_date || !end_date || !provider || !ticket_url
      render status: 405, json: {success: false, msg: "Title, start_date, end_date, provider and ticket_url should be given"}
      return
    end
    if !UpcomingTicketUrl.providers.include?(provider)
      render status: 405, json: {success: false, msg: "Provider does not match any - it should be one of #{UpcomingTicketUrl.providers}"}
      return
    end
    if TemporaryUpcoming.exists?(ticket_url: ticket_url) || UpcomingTicketUrl.exists?(ticket_url: ticket_url)
      render status: 200, json: {success: true, msg: "An upcoming with the same url exists"}
      return
    end

    tu = TemporaryUpcoming.new(title: title, place: place, start_date: start_date, end_date: end_date,
      provider: provider, ticket_url: ticket_url, artist_info: artist_info)
    tu.remote_image_url_url = image_url if image_url
    if tu.save
      render status: 201, json: {success: true, msg: "Success"}
    else
      render status: 405, json: {success: false, msg: "Unexpected error occured while saving #{tu}"}
    end
  end

  def update
    tu = TemporaryUpcoming.find(params[:id])
    uc = Upcoming.new
    uc.title = params[:temporary_upcoming][:title]
    uc.place = params[:temporary_upcoming][:place]
    uc.start_date = params[:temporary_upcoming][:start_date]
    uc.end_date = params[:temporary_upcoming][:end_date]
    image = params[:temporary_upcoming][:image_url]
    uc.image_url = image ? image : tu.image_url
    if uc.save
      if params[:temporary_upcoming][:artist_info]
        params[:temporary_upcoming][:artist_info].split(',').each do |artist_name|
          if Artist.exists?(name: artist_name)
            UpcomingArtist.create(artist_id: Artist.where(name: artist_name).take.id, upcoming_id: uc.id)
          end
        end
      end
      ticket = UpcomingTicketUrl.new
      ticket.upcoming_id = uc.id
      ticket.provider = params[:temporary_upcoming][:provider]
      ticket.ticket_url = params[:temporary_upcoming][:ticket_url]
      if ticket.save && tu.destroy
        @message = "저장되었습니다"
        render '/xhrs/alert'
      else
        render text: "TicketUrl을 연결하는 데 실패했습니다."
      end
    else
      render text: "Upcoming을 생성하는데 실패했습니다."
    end
  end

  def destroy
    if TemporaryUpcoming.find(params[:id]).destroy
      @message = "삭제되었습니다"
      render '/xhrs/alert'
    else
      render text: "삭제에 실패했습니다."
    end
  end

  def merge
    if Upcoming.exists?(params[:upcoming_id])
      temp = TemporaryUpcoming.find(params[:id])
      ticket = UpcomingTicketUrl.new
      ticket.upcoming_id = params[:upcoming_id]
      ticket.provider = temp.provider
      ticket.ticket_url = temp.ticket_url
      if ticket.save && temp.destroy
        @message = "병합되었습니다"
        render '/xhrs/alert'
      else
        render text: "실패했습니다."
      end
    else
      render text: "해당하는 Upcoming이 없습니다."
    end
  end

  def automatch
    # TODO jaeseong

  end
end
