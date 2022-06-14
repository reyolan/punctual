module TasksHelper
  def show_task_details(task_detail)
    task_detail.blank? ? 'No details provided.' : task_detail
  end

  def show_task_state(task_completed)
    task_completed ? 'Completed' : 'Not Completed'
  end
end
