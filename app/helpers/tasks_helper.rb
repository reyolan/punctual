module TasksHelper
  def query_tasks(model)
    tasks_to_complete = model.tasks.where(completed: false).order(deadline: :asc)
    tasks_completed = model.tasks.where(completed: true).order(deadline: :asc)
    { not_completed: tasks_to_complete, completed: tasks_completed }
  end
end
