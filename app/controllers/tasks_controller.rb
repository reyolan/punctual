class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_category_collection, only: %i[new create edit update]
  before_action :store_location, only: :index

  def index
    tasks = current_user.tasks.includes(:category)
    @tasks_today = tasks.not_completed_deadline_today
    @tasks_not_completed = tasks.not_completed_deadline_not_today
    @tasks_completed = tasks.completed_asc_name
  end

  def new
    @task = current_user.tasks.build
  end

  def show; end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to previous_location(fallback: @task), success: "Successfully added #{@task.name.inspect} task."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to @task, success: "Successfully updated #{@task.name.inspect} task."
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to previous_location(fallback: root_url), success: "Successfully deleted #{@task.name.inspect} task."
  end

  private

  def task_params
    params.require(:task).permit(:name, :deadline, :details, :category_id)
  end

  def set_category_collection
    @categories = current_user.categories.asc_name
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
