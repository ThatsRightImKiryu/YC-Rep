require "test_helper"

class WritingsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get writings_create_url
    assert_response :success
  end

  test "should get new" do
    get writings_new_url
    assert_response :success
  end

  test "should get update" do
    get writings_update_url
    assert_response :success
  end

  test "should get delete" do
    get writings_delete_url
    assert_response :success
  end
end
