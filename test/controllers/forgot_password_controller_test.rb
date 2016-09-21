require 'test_helper'

class ForgotPasswordControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_forgot_password_path
    assert_response :success
  end
end
