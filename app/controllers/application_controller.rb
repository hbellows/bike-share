class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :current_user, :current_admin?, :set_cart

  helper_method :require_user, :current_admin?, :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def require_user
    unless current_user
      redirect_to login_path
    end
  end

  def set_cart
    @cart ||= Cart.new(session[:cart])
  end
end
