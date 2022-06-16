require "test_helper"

class UserFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
    ActionMailer::Base.deliveries.clear
  end

  test 'should signup with valid information including account activation' do
    get new_user_registration_path
    assert_difference ['User.count', 'ActionMailer::Base.deliveries.size'], 1 do
      post user_registration_path, params: { user: { email: 'example@example.com', password: 'example123', password_confirmation: 'example123' } }
    end
    assert_not flash.empty?
    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
    created_user = User.last

    # account activation
    assert_not created_user.confirmed?
    received_mail = ActionMailer::Base.deliveries.last
    confirmation_token = created_user.confirmation_token
    assert_match user_confirmation_path(confirmation_token:), received_mail.body.to_s
    get user_confirmation_path(confirmation_token:)
    assert created_user.reload.confirmed?
  end

  test 'should not signup with invalid information' do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post user_registration_path, params: { user: { email: 'example@not_valid', password: 'exa',
                                                     password_confirmation: 'exa' } }
    end
    assert_response :success
    assert_select 'div#error_explanation'
  end

  test 'should login with valid email and password' do
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

  test 'should login with invalid email and password' do
    get new_user_session_path
    assert_select 'h2', 'Login'
    post user_session_path, params: { session: { email: ' ', password: ' ' } }
    assert_not user_logged_in?
    assert_not flash.empty?
    assert_equal I18n.t('devise.failure.invalid', authentication_keys: :Email), flash.now[:alert]
  end

  test 'should edit account details' do
    sign_in(@user)
    get edit_user_registration_path
    assert_select 'a[href=?]', user_registration_path
    assert_select 'input[value=?]', 'Update'
    # assert_difference 'ActionMailer::Base.deliveries.size', 1 do
    #   patch user_registration_path, params: { session: { email: 'example126@example.com',
    #                                                      current_password: @user.encrypted_password } }
    # end
  end

  test 'should delete account' do
    sign_in(@user)
    get edit_user_registration_path
    assert_select 'a[href=?]', user_registration_path
    assert_select 'a', 'Delete account'
    assert_difference 'User.count', -1 do
      delete user_registration_path
    end
    assert_redirected_to root_url
  end
end
