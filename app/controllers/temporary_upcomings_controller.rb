class TemporaryUpcomingsController < ApplicationController
  def update
    uc = Upcoming.new
    uc.title = params[:temporary_upcoming][:title]
    uc.place = params[:temporary_upcoming][:place]
    uc.start_date = params[:temporary_upcoming][:start_date]
    uc.end_date = params[:temporary_upcoming][:end_date]
    if uc.save
      ticket = UpcomingTicketUrl.new
      ticket.upcoming_id = uc.id
      ticket.provider = params[:temporary_upcoming][:provider]
      ticket.ticket_url = params[:temporary_upcoming][:ticket_url]
      if ticket.save
        tu = TemporaryUpcoming.find(params[:id])
        tu.destroy
        redirect_back(fallback_location: root_path)
      else
        render text: "TicketUrl을 연결하는 데 실패했습니다."
      end
    else
      render text: "Upcoming을 생성하는데 실패했습니다."
    end
  end

  def destroy
    if TemporaryUpcoming.find(params[:id]).destroy
        redirect_back(fallback_location: root_path)
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
        redirect_back(fallback_location: root_path)
      else
        render text: "실패했습니다."
      end
    else
      render text: "해당하는 Upcoming이 없습니다."
    end
  end
end
