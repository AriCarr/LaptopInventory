class ApplicationController < ActionController::Base
  include SessionsHelper
  before_filter :require_login
  before_action :store_location, :current_user
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
