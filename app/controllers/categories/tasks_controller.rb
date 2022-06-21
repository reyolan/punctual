class Categories::TasksController < ApplicationController
  include CategoryScoped

  before_action :set_category_collection, only: :new
  before_action :store_location, only: :index

  def index
    @tasks_today = @category.tasks.not_completed_deadline_today
    @tasks_not_completed = @category.tasks.not_completed_deadline_not_today
    @tasks_completed = @category.tasks.completed_asc_name
  end

  def new
    @task = @category.tasks.build
    render 'tasks/new'
  end

  private

  def set_category_collection
    @categories = current_user.categories.asc_name
  end
end
