class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  add_flash_types :success, :danger

  private

  def query_tasks(model)
    @tasks_today = model.tasks.not_completed.where(deadline: Date.current)
    @tasks_not_completed = model.tasks.where.not(deadline: Date.current)
                                .or(model.tasks.where(deadline: nil)).not_completed.order(:deadline)
    @tasks_completed = model.tasks.completed.order(:name)
  end

  def store_location
    session[:previous_page] = request.original_url
  end

  def previous_location(fallback:)
    session.delete(:previous_page) || fallback
  end
end
