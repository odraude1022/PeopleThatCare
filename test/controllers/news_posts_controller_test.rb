require 'test_helper'

class NewsPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get news_posts_show_url
    assert_response :success
  end

  test "should get new" do
    get news_posts_new_url
    assert_response :success
  end

end
