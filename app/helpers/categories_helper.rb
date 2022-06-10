module CategoriesHelper
  def count_not_completed_task(category)
    category.tasks.where(completed: false).count
  end

  def count_completed_task(category)
    category.tasks.where(completed: true).count
  end
end
