require "test_helper"

class TaskFlowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
    @coding_category = categories(:coding)
    @task = tasks(:valid_task)
  end

  test 'should create a task for a specific category' do
    sign_in(@user)
    get new_task_path
    assert_select 'label', count: 4
    assert_select 'h1', 'Add Task'
    name = 'Learn Ruby'
    assert_difference 'Task.count', 1 do
      post tasks_path, params: { task: { name:, details: 'Lorem ipsum', deadline: '',
                                         category_id: @coding_category.id } }
    end
    assert_redirected_to Task.last
    assert_equal @user.id, Task.last.category.user_id
    follow_redirect!
    assert_select 'h1', name
    assert_not flash.empty?
    assert_equal "Successfully added #{name.inspect} task.", flash[:success]
  end

  test 'should not create a task for a specific category with invalid fields' do
    sign_in(@user)
    get new_task_path
    assert_select 'label', count: 4
    assert_select 'h1', 'Add Task'
    assert_no_difference 'Task.count' do
      post tasks_path, params: { task: { name: '', details: 'Lorem ipsum', deadline: '',
                                         category_id: @coding_category.id } }
    end
    assert_select 'label', count: 4
    assert_select 'h1', 'Add Task'
    assert_select 'div#error_explanation'
  end

  test 'should edit a task' do
    sign_in(@user)
    get task_path(@task)
    assert_select 'a[href=?]', edit_task_path(@task)
    get edit_task_path(@task)
    name = 'Lorem ipsumsss'
    patch task_path(@task), params: { task: { name:, category_id: @task.category_id, deadline: @task.deadline,
                                              details: @task.details } },
                            headers: { 'HTTP_REFERER' => edit_task_url(@task) }
    @task.reload
    assert_not flash.empty?
    assert_equal "Successfully updated #{@task.name.inspect} task.", flash[:success]
    assert_equal name, @task.name
    assert_redirected_to @task
    follow_redirect!
    assert_select 'h1', name
  end

  test 'should view a task' do
    sign_in(@user)
    get task_path(@task)
    assert_select 'h1', @task.name
    assert_select 'p', show_task_details(@task.details)
    assert_select 'p', rephrase_deadline(@task.deadline)
    assert_select 'p', show_task_state(@task)
  end

  test 'should delete a task' do
    sign_in(@user)
    get task_path(@task)
    assert_select 'a[href=?]', task_path(@task)
    assert_difference 'Task.count', -1 do
      delete task_path(@task)
    end
    assert_redirected_to root_url
    assert_not flash.empty?
  end

  test 'should view tasks for today' do
    sign_in(@user)
    get root_path
    assert_select 'p', @task.name
    assert_select '[data-deadline]', 'Today'
  end

  test 'should view all tasks' do
    sign_in(@user)
    get root_path
    @user.tasks.each do |task|
      assert_select 'p', task.name
    end
  end

  test 'should delete all completed tasks' do
    sign_in(@user)
    get root_path
    assert_select 'a[href=?]', completed_tasks_path
    delete completed_tasks_path
    assert_equal 0, @user.tasks.completed.count
  end

  test 'should delete all completed tasks in a specific category' do
    sign_in(@user)
    category = categories(:category_one)
    get category_tasks_path(category)
    assert_select 'a[href=?]', category_completed_tasks_path(category)
    delete category_completed_tasks_path(category)
    assert_equal 0, category.tasks.completed.count
  end
end
