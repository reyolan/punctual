class TasksController < ApplicationController
  include TasksHelper
  before_action :authenticate_user!
  before_action :set_task, :user_owns_task?, only: %i[show edit update destroy]
  before_action :set_task_collection, only: %i[new edit create update]

  def index
    @tasks = query_tasks(current_user)
  end

  def new
    @task = Task.new
  end

  def show; end

  def create
    @task = current_user.tasks.build(task_params)
    # Take note of this
    @task.user_id = current_user.id
    if @task.save
      redirect_to root_url, success: 'Successfully added task.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to root_url, success: 'Successfully updated task'
    else
      render :update
    end
  end

  def destroy
    @task.destroy
    redirect_to request.referrer || root_url
  end

  private

  def task_params
    params.require(:task).permit(:name, :deadline, :completed, :category_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_task_collection
    @categories = current_user.categories
  end

  def user_owns_task?
    return if current_user == @task.user

    redirect_to request.referrer || root_url, danger: "You cannot access/modify another user's task"
  end
end
