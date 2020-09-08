require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get Dashboard" do
    get home_Dashboard_url
    assert_response :success
  end

end
