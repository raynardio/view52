class ApplicationController < ActionController::Base
  before_action :configure_sign_up_params, if: :devise_controller?

  # include CanCan::ControllerAdditions

  # rescue_from CanCan::AccessDenied do |_|
  #   flash[:error] = t :access_denied
  #   redirect_to root_url
  # end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
