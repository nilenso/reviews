class Users::SettingsController < ApplicationController
  def update
    current_user.settings(:user_settings).color_scheme
    current_user.settings(:user_settings).update!(color_scheme: params.require(:color_scheme))

    redirect_to :user_reviews
  end
end
