class SessionsController < ApplicationController
  skip_before_action :store_location, :require_login

  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
    rescue
      flash[:warning] = "There was an error while trying to authenticate you..."
    end
  redirect_back_or @user
  end

  def destroy
    if current_user
      session.delete(:user_id)
    end
    redirect_to root_path
  end
end
