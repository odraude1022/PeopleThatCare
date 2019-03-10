require 'test_helper'

class CharitySessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get charity_sessions_new_url
    assert_response :success
  end

end
