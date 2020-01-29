require 'test_helper'

class GoodControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get good_create_url
    assert_response :success
  end

  test "should get destroy" do
    get good_destroy_url
    assert_response :success
  end

end
