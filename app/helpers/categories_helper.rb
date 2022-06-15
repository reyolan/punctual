module CategoriesHelper
  def count_not_completed_task(category)
    category.tasks.not_completed.count
  end

  def count_completed_task(category)
    category.tasks.completed.count
  end
end
