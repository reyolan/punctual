require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @user = users(:mike)
    @another_user = users(:kevin)
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
    @category.name = '   '
    assert_not @category.valid?
  end

  test 'name should be at most 24 characters' do
    @category.name = 'a' * 25
    assert_not @category.valid?
  end

  test 'asc_name scoping should be ascending' do
    assert_equal categories(:first_ascending), Category.all.asc_name.first
  end

  test 'name should be unique in the scope of each user' do
    @category.save
    category_two = @user.categories.build(name: 'School')
    assert_not category_two.save
    assert @another_user.categories.create(name: 'School')
  end

  test 'associated tasks should be destroyed' do
    @category.save
    @category.tasks.create!(name: 'Task123')
    assert_difference 'Task.count', -1 do
      @category.destroy
    end
  end
end
