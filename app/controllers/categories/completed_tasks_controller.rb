class Categories::CompletedTasksController < ApplicationController
  include CategoryScoped

  def destroy_all
    @category.tasks.destroy_all
    redirect_back(fallback_location: root_url,
                  success: 'Successfully deleted all completed tasks in this category.')
  end
end
