class UsersController < ApplicationController
	before_action :require_admin, only: [:index, :edit, :update, :destroy]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to root_path, notice: "Thank you for signing up!"
		else
			render "new"
		end
	end

	def edit
	end

	def update
	end

	private
	def user_params
		params.require(:user).permit(:full_name, :email, :password_digest, :password, :password_confirmation)
	end
end
