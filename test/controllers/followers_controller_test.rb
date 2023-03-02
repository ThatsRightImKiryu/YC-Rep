require "test_helper"

class FollowersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get followers_new_url
    assert_response :success
  end

  test "should get destroy" do
    get followers_destroy_url
    assert_response :success
  end
end
