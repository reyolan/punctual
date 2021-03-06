require "test_helper"

class CategoryFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
    @first_category = @user.categories.first
  end

  test 'should create a category' do
    get new_user_session_path
    sign_in(@user)
    get new_category_path
    assert_select 'label'
    assert_select 'h1', 'Add Category'
    name = 'Example'
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: } }
    end
    assert_not flash.empty?
    follow_redirect!
    assert_response :success
    assert_select 'h1', name
  end

  test 'should not create a category with invalid information' do
    sign_in(@user)
    get new_category_path
    assert_select 'label'
    assert_select 'h1', 'Add Category'
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: 'a' * 25 } }
    end
    assert_response :success
    assert_select 'label'
    assert_select 'h1', 'Add Category'
    assert_select 'div#error_explanation'
  end

  test 'should edit a category' do
    sign_in(@user)
    get category_tasks_path(@first_category)
    assert_select 'h1', @first_category.name
    name = 'Example123'
    patch category_path(@first_category), params: { category: { name: } }
    assert_not flash.empty?
    assert_equal "Successfully updated #{name.inspect} category.", flash[:success]
    assert_redirected_to category_tasks_url(@first_category)
    follow_redirect!
    assert_response :success
    assert_select 'h1', name
  end

  test 'should not edit a category with invalid information' do
    sign_in(@user)
    get category_tasks_path(@first_category)
    patch category_path(@first_category), params: { category: { name: 'a' * 25 } }
    assert_select 'div#error_explanation'
  end

  test 'should see all the categories of the user' do
    sign_in(@user)
    get categories_path
    assert_select 'h1', 'Categories'
    @user.categories.each do |category|
      assert_select 'h1', category.name
    end
  end

  test 'should view a specific category to show its details' do
    sign_in(@user)
    get category_tasks_path(@first_category)
    assert_select 'h1', @first_category.name
    assert_select 'div#task-list'
  end
end
