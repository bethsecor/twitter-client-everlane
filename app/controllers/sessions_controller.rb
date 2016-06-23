class SessionsController < ApplicationController
  def create
    user = User.find_or_create_by_auth(request.env['omniauth.auth'])
    if user
      session[:user_id] = user.id
      redirect_to '/banners'
    end
  end
end
