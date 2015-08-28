class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  add_flash_types :info, :warning

private
	def current_user
		@current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
	end

	def require_user 
  		redirect_to login_path unless current_user
	end

	def require_admin
		redirect_to login_path unless current_user && current_user.admin?
	end

	def require_routesetter
		redirect_to login_path unless current_user && (current_user.routesetter? || current_user.admin?)
	end
end
