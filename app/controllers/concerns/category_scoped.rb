module CategoryScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_category
  end

  private

  def set_category
    @category = current_user.categories.find(params[:category_id])
  end

  def set_category_collection
    @categories = current_user.categories.asc_name
  end
end
