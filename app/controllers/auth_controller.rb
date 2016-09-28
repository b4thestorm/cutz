class AuthController < ApplicationController

def callback
  #you should add a begin/rescue just in case a failure occurs here. 
  #request = request.env['omniauth.auth']['credentials']
  current_user.cronofy_access_token = request.env['omniauth.auth']['credentials']['token']
  current_user.cronofy_refresh_token = request.env['omniauth.auth']['credentials']['refresh_token']
  current_user.expiration = request.env['omniauth.auth']['credentials']['expires_at']
  current_user.save


  redirect_to barber_path(current_user.id)
end

end
