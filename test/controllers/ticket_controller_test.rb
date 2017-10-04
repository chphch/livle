require 'test_helper'

class TicketControllerTest < ActionDispatch::IntegrationTest
  test "should get info" do
    get ticket_info_url
    assert_response :success
  end

  test "should get book" do
    get ticket_book_url
    assert_response :success
  end

end
