class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

      def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:nickname, :name, :last_name, :email, :password, :password_confirmation) }
          devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:nickname, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar) }
      end
end
