class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :ensure_user_logged_in

  def current_user
    UserDecorator.decorate(super) unless super.nil?
  end

  def ensure_user_logged_in
    unless current_user
      redirect_to Rails.application.routes.url_helpers.user_omniauth_authorize_path(:google_oauth2)
    end
  end
end
