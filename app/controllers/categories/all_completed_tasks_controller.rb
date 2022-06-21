class Categories::AllCompletedTasksController < ApplicationController
  include CategoryScoped

  def destroy
    @category.tasks.completed.destroy_all
    redirect_to category_tasks_url(@category), success: 'Successfully deleted all completed tasks in this category.'
  end
end
