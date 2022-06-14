require "test_helper"

class CategoriesEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
    @first_category = @user.categories.first
  end

  test 'can edit a category' do
    get new_user_session_path
    sign_in(@user)
    get category_path(@first_category)
    name = 'Example123'
    patch category_path(@first_category), params: { category: { name: } }
    assert_not flash.empty?
    follow_redirect!
    assert_response :success
    assert_select 'h1', name
  end

  test 'cannot edit a category with invalid information' do
    get new_user_session_path
    sign_in(@user)
    get category_path(@first_category)
    patch category_path(@first_category), params: { category: { name: 'a' * 25 } }
    assert_select 'div#error_explanation'
  end
end
