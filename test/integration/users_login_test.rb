require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
  end

  test 'login with valid email and password' do
    get new_user_session_path
    assert_select 'h2', 'Login'
    sign_in(@user)
    post user_session_path
    assert user_logged_in?
    assert_redirected_to authenticated_root_url
    follow_redirect!
    assert_not flash.empty?
    assert_select 'h1', "Welcome, #{get_email_username(@user.email)}!"
  end

  test 'login with invalid information' do
    get new_user_session_path
    assert_select 'h2', 'Login'
    post user_session_path, params: { session: { email: ' ', password: ' ' } }
    assert_not user_logged_in?
    assert_not flash.empty?
    assert_equal I18n.t('devise.failure.invalid', authentication_keys: :Email), flash.now[:alert]
  end
end
