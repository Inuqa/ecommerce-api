class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  helper_method :login!, :logged_in?, :current_user, :authorized_user?, :logout!, :set_user

  def login!
    session[:admin_id] = @admin_id
  end

  def logged_in?
    !!session[:admin_id]
  end

  def current_user
    @current_user ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

  def authorized_user?
    @admin == current_user
  end

  def logout!
    session.clear
  end

  def set_user
    @admin = Admin.find_by(id: session[:admin_id])
  end
end
