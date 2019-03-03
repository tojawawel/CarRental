class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:username,:first_name, :last_name, :phone_number, :gender, :date_of_birth, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :account_update, keys: [:username,:first_name, :last_name, :phone_number, :gender, :date_of_birth, :email, :password, :password_confirmation, :remember_me]
  end
end
