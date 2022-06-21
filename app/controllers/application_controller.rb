class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  add_flash_types :success, :danger

  private

  def store_location
    session[:previous_page] = request.original_url
  end

  def previous_location(fallback:)
    session.delete(:previous_page) || fallback
  end
end
