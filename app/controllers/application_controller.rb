class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :store_location, :current_user, :require_login
  skip_before_action :require_login, only: [:new, :create]
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    if !current_user
      flash[:warning] = "Sorry, please #{view_context.link_to 'LOG IN', '/auth/office365'} to view that page..."
      redirect_to root_path
    end
  end

  helper_method :current_user
end
