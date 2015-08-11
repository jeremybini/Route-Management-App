class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to gyms_path, notice: "Thank you for signing up!"
		else
			render "new"
		end
	end

	private
	def user_params
		params.require(:user).permit(:full_name, :email, :password_digest, :password, :password_confirmation)
	end
end