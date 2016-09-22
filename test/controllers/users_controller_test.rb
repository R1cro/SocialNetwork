require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @other_user = users(:archer)
  end

  def log_in_as(user, options = {})
    password    = options[:password]    || 'password'
    remember_me = options[:remember_me] || '1'
    post login_path, session: { email:       user.email,
                                  password:    password,
                                  remember_me: remember_me }
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
      user: { password:              "12345678",
              password_confirmation: "12345678",
              admin: true } }
    assert_not @other_user.admin?
  end


end
