class TasksController < ApplicationController
  before_action :authenticate_user!
  
  def create; end

  def destroy; end

  private

  def task_params
    params.require(:task).permit(:name, :deadline, :complete)
  end
end
