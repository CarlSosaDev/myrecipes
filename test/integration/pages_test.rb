require 'test_helper'

class PagesTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get pages_home_url
    assert_response :success
  end

  test "should get" do
    get root_url
    assert_response :sucess
  end
end
