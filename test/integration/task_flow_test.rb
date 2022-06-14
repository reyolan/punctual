require "test_helper"

class TaskFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
    @coding_category = categories(:coding)
    @task = tasks(:valid_task)
  end

  test 'can create a task for a specific category' do
    sign_in(@user)
    get new_task_path
    assert_select 'label', count: 4
    assert_select 'h1', 'Add Task'
    name = 'Learn Ruby'
    assert_difference 'Task.count', 1 do
      post tasks_path, params: { task: { name:, details: 'Lorem ipsum', deadline: '', category_id: @coding_category.id } }
    end
    assert_redirected_to @user.tasks.last
    follow_redirect!
    assert_response :success
    assert_select 'h1', name
    assert_not flash.empty?
    assert_equal "Successfully added #{name.inspect} task.", flash[:success]
  end

  test 'cannot create a task for a specific category with invalid fields' do
    sign_in(@user)
    get new_task_path
    assert_select 'label', count: 4
    assert_select 'h1', 'Add Task'
    assert_no_difference 'Task.count' do
      post tasks_path, params: { task: { name: '', details: 'Lorem ipsum', deadline: '', category_id: @coding_category.id } }
    end
    assert_response :success
    assert_select 'label', count: 4
    assert_select 'h1', 'Add Task'
    assert_select 'div#error_explanation'
  end

  test 'can edit a task' do
    sign_in(@user)
    get task_path(@task)
    assert_select 'a[href=?]', edit_task_path(@task)
    get edit_task_path(@task)
    name = 'Lorem ipsumsss'
    patch task_path(@task), params: { task: { name: } }
    assert_not flash.empty?
    assert_equal 'Successfully updated task.', flash[:success]
    assert_redirected_to @task
    follow_redirect!
    assert_response :success
    assert_select 'h1', name
  end

  test 'can view a task' do
    sign_in(@user)
    get task_path(@task)
    assert_select 'h1', @task.name
    assert_select 'p', show_task_details(@task.details)
    assert_select 'p', rephrase_deadline(@task.deadline)
    assert_select 'p', show_task_state(@task.completed)
  end

  test 'can delete a task' do
    sign_in(@user)
    get task_path(@task)
    assert_select 'a[href=?]', task_path(@task)
    assert_difference 'Task.count', -1 do
      delete task_path(@task)
    end
    assert_redirected_to @task.category
    assert_not flash.empty?
  end

  test 'can view tasks for today' do
    sign_in(@user)
    get root_path
    assert_select 'h2', "Today (#{Date.current})"
    assert_select 'p', @task.name
    assert_select '[data-deadline]', 'Today'
  end

  test 'can view all tasks' do
    sign_in(@user)
    get root_path
    @user.tasks.each do |task|
      assert_select 'p', task.name
    end
  end

  test 'can delete all completed tasks' do
    sign_in(@user)
    get root_path
    assert_select 'a[href=?]', tasks_destroy_completed_path
    delete tasks_destroy_completed_path
    assert_equal 0, @user.tasks.completed.count
  end

  test 'can delete all completed tasks in a specific category' do
    sign_in(@user)
    category = categories(:category_one)
    get category_path(category)
    assert_select 'a[href=?]', category_tasks_destroy_completed_path(category)
    delete category_tasks_destroy_completed_path(category)
    assert_equal 0, category.tasks.completed.count
  end
end
