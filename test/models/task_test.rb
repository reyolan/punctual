require "test_helper"

class TaskTest < ActiveSupport::TestCase
  def setup
    @task = tasks(:valid_task)
  end

  test 'should be valid' do
    @task.valid?
  end

  test 'category should be present' do
    @task.category = nil
    assert_not @task.valid?
  end

  test 'name should be present' do
    @task.name = '   '
    assert_not @task.valid?
  end

  test 'completed :scope should return completed tasks' do
    assert Task.completed.exists?(tasks(:completed_task).id)
  end

  test 'completed :scope should not return not completed tasks' do
    assert_not Task.completed.exists?(tasks(:not_completed_task).id)
  end

  test 'not_completed :scope should return not completed tasks' do
    assert Task.not_completed.exists?(tasks(:not_completed_task).id)
  end

  test 'not_completed :scope should not return completed tasks' do
    assert_not Task.not_completed.exists?(tasks(:completed_task).id)
  end
end
