require "test_helper"

class UserFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
    ActionMailer::Base.deliveries.clear
  end

  test 'can signup with valid information' do
    get new_user_registration_path
    assert_difference ['User.count', 'ActionMailer::Base.deliveries.size'], 1 do
      post user_registration_path, params: { user: { email: 'example@example.com', password: 'example123', password_confirmation: 'example123' } }
    end
    assert_not flash.empty?
    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
  end

  test 'cannot signup with invalid information' do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post user_registration_path, params: { user: { email: 'example@not_valid', password: 'exa',
                                                     password_confirmation: 'exa' } }
    end
    assert_response :success
    assert_select 'div#error_explanation'
  end

  test 'can login with valid email and password' do
    get new_user_session_path
    assert_select 'h2', 'Login'
    assert_select 'a[href=?]', categories_path, count: 0
    assert_select 'a[href=?]', edit_user_registration_path, count: 0
    assert_select 'a[href=?]', destroy_user_session_path, count: 0
    assert_select 'a[href=?]', new_user_session_path
    assert_select 'a[href=?]', new_user_registration_path
    sign_in(@user)
    post user_session_path
    assert user_logged_in?
    assert_redirected_to authenticated_root_url
    follow_redirect!
    assert_select 'a[href=?]', categories_path
    assert_select 'a[href=?]', edit_user_registration_path
    assert_select 'a[href=?]', destroy_user_session_path
    assert_select 'a[href=?]', new_user_session_path, count: 0
    assert_select 'a[href=?]', new_user_registration_path, count: 0
    assert_response :success
    assert_not flash.empty?
    assert_select 'h1', "Welcome, #{get_email_username(@user.email)}!"
  end

  test 'cannot login with invalid email and password' do
    get new_user_session_path
    assert_select 'h2', 'Login'
    post user_session_path, params: { session: { email: ' ', password: ' ' } }
    assert_not user_logged_in?
    assert_not flash.empty?
    assert_equal I18n.t('devise.failure.invalid', authentication_keys: :Email), flash.now[:alert]
  end
end
