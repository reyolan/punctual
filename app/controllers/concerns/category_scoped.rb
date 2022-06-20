module CategoryScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_category
  end

  private

  def set_category
    @category = current_user.categories.find(params[:category_id])
  end
end
