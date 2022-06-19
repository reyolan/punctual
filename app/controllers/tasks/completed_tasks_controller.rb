class Tasks::CompletedTasksController < ApplicationController
  def destroy_all
    current_user.tasks.completed.destroy_all
    redirect_back(fallback_location: root_url,
                  success: 'Successfully deleted all completed tasks.')
  end
end
