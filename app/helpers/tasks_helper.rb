module TasksHelper
  def query_tasks(model)
    today = model.tasks.where(completed: false).where(deadline: Date.today)
    not_completed = model.tasks.where(completed: false).where.not(deadline: Date.today)
    completed = model.tasks.where(completed: true)
    { today:, not_completed:, completed: }
  end
end
