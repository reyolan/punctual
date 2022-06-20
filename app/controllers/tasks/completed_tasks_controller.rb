class Tasks::CompletedTasksController < ApplicationController
  before_action :set_task, only: :update

  def update
    @task.update(completed_task_params)
    redirect_back(fallback_location: root_url)
  end

  def destroy_all
    current_user.tasks.completed.destroy_all
    redirect_to root_url, success: 'Successfully deleted all completed tasks in this category.'
  end

  private

  def completed_task_params
    params.require(:task).permit(:completed)
  end

  def set_task
    @task = current_user.tasks.find(params[:task_id])
  end
end
