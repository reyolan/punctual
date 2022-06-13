require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @user = users(:mike)
    @category = @user.categories.build(name: 'School')
  end

  test 'should be valid' do
    assert @category.valid?
  end

  test 'user should be present' do
    @category.user = nil
    assert_not @category.valid?
  end

  test 'name should be present' do
    @category.name = nil
    assert_not @category.valid?
  end

  test 'name should not be too long' do
    @category.name = 'a' * 25
    assert_not @category.valid?
  end

  test 'asc_name scoping should be ascending' do
    assert_equal categories(:first_ascending), Category.all.asc_name.first
  end
end
