class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :gyms, :setters

  add_flash_types :info, :warning

private
	def current_user
		@current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
	end

	def gyms
		@gyms = Gym.all
	end

	def setters
		@setters = User.where(role: ["Routesetter", "Admin", "Super Admin"]).order("full_name")
	end

	def require_user 
  		redirect_to root_path unless current_user
	end

	def require_super_admin
		redirect_to root_path unless current_user && current_user.super_admin?
	end

	def require_admin
		redirect_to root_path unless current_user && current_user.admin?
	end

	def require_routesetter
		redirect_to root_path unless current_user && current_user.routesetter?
	end
end
