class ApplicationController < ActionController::Base

  before_action :configure_permitted_paramaters, if: :devise_controller?

  private

  def configure_permitted_paramaters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :avatar, :introduction, :first_name, :first_name_reading, :last_name, :last_name_reading, :birthday, :earnings, :points, address_attributes: [:phone_number, :postal_code, :prefecture, :city, :house_number, :building_name]])
  end
  
end

