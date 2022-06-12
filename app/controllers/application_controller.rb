class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  add_flash_types :success, :danger

  private

  def query_tasks(model)
    today = model.tasks.where(completed: false).where(deadline: Date.current)
    nil_deadline_not_completed = model.tasks.where(completed: false).where(deadline: nil)
    not_completed = model.tasks.where(completed: false).where.not(deadline: Date.current).or(nil_deadline_not_completed)
    completed = model.tasks.where(completed: true)
    { today:, not_completed:, completed: }
  end
end
