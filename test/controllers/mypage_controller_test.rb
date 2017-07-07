require 'test_helper'

class MypageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mypage_index_url
    assert_response :success
  end

  test "should get edit_profile" do
    get mypage_edit_profile_url
    assert_response :success
  end

  test "should get settings" do
    get mypage_settings_url
    assert_response :success
  end

end
