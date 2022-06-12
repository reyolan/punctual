class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

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
      redirect_to @category, success: "Successfully added #{@category.name.inspect} category."
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
    redirect_to categories_url, success: "Successfuly deleted #{@category.name.inspect} category."
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = current_user.categories.find(params[:id])
  end
end
