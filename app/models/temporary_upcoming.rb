class TemporaryUpcoming < ApplicationRecord
  mount_uploader :image_url, S3Uploader
  validate :check_duplicate
  def check_duplicate
    if UpcomingTicketUrl.exists?(ticket_url: self.ticket_url)
      errors.add(:ticket_url, "이미 존재하는 Upcoming 데이터입니다.");
    end
  end
end
