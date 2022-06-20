class Categories::CompletedTasksController < ApplicationController
  include CategoryScoped

  def destroy_all
    @category.tasks.completed.destroy_all
    redirect_to category_tasks_url(@category), success: 'Successfully deleted all completed tasks in this category.'
  end
end
