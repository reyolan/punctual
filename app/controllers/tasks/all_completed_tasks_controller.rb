class Tasks::AllCompletedTasksController < ApplicationController
  def destroy
    current_user.tasks.completed.destroy_all
    redirect_to root_url, success: 'Successfully deleted all completed tasks in this category.'
  end
end
