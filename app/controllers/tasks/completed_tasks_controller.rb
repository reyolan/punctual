class Tasks::CompletedTasksController < ApplicationController
  include TaskScoped

  def create
    @task.complete
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @task.uncomplete
    redirect_back(fallback_location: root_url)
  end
end
