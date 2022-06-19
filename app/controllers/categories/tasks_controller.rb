class Categories::TasksController < ApplicationController
  include CategoryScoped

  before_action :set_category_collection, only: :new
  before_action :store_location, only: :index

  def index
    query_tasks(@category)
  end

  def new
    @task = @category.tasks.build
    render 'tasks/new'
  end
end
