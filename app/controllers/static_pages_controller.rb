class StaticPagesController < ApplicationController
  include TasksHelper

  def home; end

  def welcome
    @tasks = query_tasks(current_user)
  end
end
