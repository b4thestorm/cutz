class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

def resource_name
    :user
end

def resource
    @user ||= User.new
end

def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
end

def after_sign_in_path_for(resource)
  barber_path(resource.id)
end

end
