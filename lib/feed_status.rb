class FeedStatus
  def initialize  #construct
    @status = 'official' if @status == nil
  end

  def get_status
    @status
  end

  def set_status(type)
    @status = type
  end
end