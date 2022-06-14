require "test_helper"

class UserFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
    ActionMailer::Base.deliveries.clear
  end

  test 'valid signup information' do
    get new_user_registration_path
    assert_difference ['User.count', 'ActionMailer::Base.deliveries.size'], 1 do
      post user_registration_path, params: { user: { email: 'example@example.com', password: 'example123', password_confirmation: 'example123' } }
    end
    assert_not flash.empty?
    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
  end

  test 'invalid signup information' do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post user_registration_path, params: { user: { email: 'example@not_valid', password: 'exa',
                                                     password_confirmation: 'exa' } }
    end
    assert_select 'div#error_explanation'
  end

  test 'login with valid email and password' do
    get new_user_session_path
    assert_select 'h2', 'Login'
    sign_in(@user)
    post user_session_path
    assert user_logged_in?
    assert_redirected_to authenticated_root_url
    follow_redirect!
    assert_response :success
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
