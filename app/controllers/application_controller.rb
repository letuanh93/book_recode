class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit :name, :user_name,
      :sex, :birthday, :phone_number, :address, :status, :email, :password,
      :password_confirmation, :avatar}
    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit :name,
      :user_name,:sex, :birthday, :phone_number, :address, :status, :email,
      :password, :password_confirmation, :avatar}
  end
end
