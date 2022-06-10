class CategoriesController < ApplicationController
  include TasksHelper
  before_action :authenticate_user!
  before_action :set_category, :user_owns_category?, only: %i[show edit update destroy]

  def index
    @categories = current_user.categories.all
  end

  def show
    @tasks = query_tasks(@category)
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to categories_url, success: "Successfully added #{@category.name.inspect} category."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_url, success: "Successfuly updated #{@category.name.inspect} category."
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def user_owns_category?
    return if current_user == @category.user

    redirect_to request.referrer || root_url, danger: "You cannot access/modify another user's category"
  end
end
