require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test 'valid signup information' do
    get new_user_registration_path
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: { email: 'example@example.com', password: 'example123', password_confirmation: 'example123' } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
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
end
