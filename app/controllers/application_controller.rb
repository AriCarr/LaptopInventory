class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :store_location, except: :seed
  before_action :current_user, :require_login
  protect_from_forgery with: :exception

  def seed
    `rails db:seed`
    redirect_back_or root_path
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    if !current_user
      store_location
      redirect_to '/auth/office365'
    end
  end

  helper_method :current_user
end
