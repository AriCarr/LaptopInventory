class ApplicationController < ActionController::Base
  helper :all
  before_filter :require_login
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    if !current_user
      flash[:warning] = 'Sorry, you must be logged in to view that page...'
      redirect_to root_path
    end
  end

  helper_method :current_user
end
