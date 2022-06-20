class Categories::CompletedTasksController < ApplicationController
  include CategoryScoped

  def destroy
    @category.tasks.destroy_all
    redirect_to @category, success: 'Successfully deleted all completed tasks in this category.'
  end
end
