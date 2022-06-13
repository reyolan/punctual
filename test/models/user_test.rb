require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: 'example@example.com', password: 'Test123456')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'email should be present' do
    @user.email = '  '
    assert_not @user.valid?
  end

  test 'password should be present' do
    @user.password = '  '
    assert_not @user.valid?
  end

  test 'password should be at least 6 characters' do
    @user.password = 'a' * 5
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[example123@example.com EXAMPLE.123@bar.COM ZXCR@foo.bar.org user+123@edu.ph]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com example@example. example@ex_ample.com example@ex+ample.com ex@ample..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique' do
    duplicate = users(:mike).dup
    assert_not duplicate.valid?
  end

  test 'associated categories should be destroyed' do
    user_one = users(:user_without_category)
    @category = user_one.categories.create!(name: 'foobar')
    assert_difference 'Category.count', -1 do
      user_one.destroy
    end
  end
end
