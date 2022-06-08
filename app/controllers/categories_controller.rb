class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[destroy show edit update]

  def index
    @categories = Categories.all.order(name: :asc)
  end

  def show
    # Add task here through Active Record Association
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
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
end
