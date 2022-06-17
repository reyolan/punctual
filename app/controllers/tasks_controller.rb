class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_category_collection, only: %i[new create edit update]
  before_action :set_category, only: %i[new destroy_completed]
  before_action :store_location, only: %i[index]

  def index
    @tasks = query_tasks(current_user)
  end

  def new
    @task = @category ? @category.tasks.build : current_user.tasks.build
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
      if request.referer == edit_task_url(@task)
        redirect_to @task, success: "Successfully updated #{@task.name.inspect} task."
      else
        redirect_to previous_location(fallback: root_url)
      end
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "Successfully deleted #{@task.name.inspect} task."
    redirect_to previous_location(fallback: root_url), success: "Successfully deleted #{@task.name.inspect} task."
  end

  def destroy_completed
    @category ? @category.tasks.completed.destroy_all : current_user.tasks.completed.destroy_all
    redirect_back(fallback_location: root_url,
                  success: "Successfully deleted all completed tasks#{' in this category' if @category}.")
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
    @categories = current_user.categories.asc_name
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
