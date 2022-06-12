class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_category_collection, only: %i[new create edit update]
  before_action :set_category, only: %i[new]

  def index
    @tasks = query_tasks(current_user)
  end

  def new
    @task = Task.new
  end

  def show; end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      # TODO: Try conditional redirect
      redirect_to @task, success: "Successfully added #{@task.name.inspect} task."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to root_url, success: 'Successfully updated task.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    # TODO: Change redirection
    redirect_to root_url, success: "Successfully deleted #{@task.name.inspect} task."
  end

  private

  def task_params
    params.require(:task).permit(:name, :deadline, :details, :completed, :category_id)
  end

  def set_category
    return unless params[:category_id]

    @category = current_user.categories.find(params[:category_id])
  end

  def set_category_collection
    @categories = current_user.categories
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
