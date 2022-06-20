class Tasks::CompletedTasksController < ApplicationController
  def destroy_all
    current_user.tasks.completed.destroy_all
    redirect_to root_url, success: 'Successfully deleted all completed tasks in this category.'
  end
end