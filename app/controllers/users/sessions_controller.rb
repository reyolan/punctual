# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    super
    flash.delete(:notice)
  end

  # DELETE /resource/sign_out
  def destroy
    super
    flash.delete(:notice)
  end
end
