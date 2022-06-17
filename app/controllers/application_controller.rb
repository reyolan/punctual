class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  add_flash_types :success, :danger

  private

  def query_tasks(model)
    @tasks_today = model.tasks.not_completed.where(deadline: Date.current)
    nil_deadline_not_completed = model.tasks.not_completed.where(deadline: nil)
    @tasks_not_completed = model.tasks.not_completed.where.not(deadline: Date.current).or(nil_deadline_not_completed)
    @tasks_completed = model.tasks.completed
  end

  def store_location
    session[:previous_page] = request.original_url
  end

  def previous_location(fallback:)
    session.delete(:previous_page) || fallback
  end
end
