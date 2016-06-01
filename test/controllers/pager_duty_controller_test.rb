require 'test_helper'

class PagerDutyControllerTest < ActionController::TestCase
  test "should get webhook" do
    get :webhook
    assert_response :success
  end

end
