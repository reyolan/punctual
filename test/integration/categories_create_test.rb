require "test_helper"

class CategoriesCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
  end

  test 'can create a category' do
    get new_user_session_path
    sign_in(@user)
    get new_category_path
    name = 'Example'
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: } }
    end
    assert_not flash.empty?
    follow_redirect!
    assert_response :success
    assert_select 'h1', name
  end

  test 'cannot create a category with invalid information' do
    get new_user_session_path
    sign_in(@user)
    get new_category_path
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: 'a' * 25 } }
    end
    assert_select 'div#error_explanation'
  end
end
