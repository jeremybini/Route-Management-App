class UsersController < ApplicationController
	before_action :require_admin, only: [:index, :destroy]
	before_action :require_user, only: [:profile, :edit, :update]
	before_action :set_user, only: [:edit, :update, :profile, :destroy]


	def index
		@employees = User.where(role: ["Routesetter", "Admin"]).order("role")
		@users = User.where(role: "User").order("full_name")
	end

	def new
		@user = User.new
	end

	def profile
	end

	def routesetter
	  @routesetter = User.find(params[:id])
	end

	def admin
      @setters = User.where(role: ["Routesetter", "Admin"]).order("full_name")
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
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to users_path, notice: "Profile updated." }
          format.json { render :profile, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

	def destroy
		@user.destroy
	    respond_to do |format|
	      format.html { redirect_to users_path, alert: "User destroyed." }
	      format.json { head :no_content }
    	end
	end

	private

	  def set_user
	  	@user = User.find(params[:id])
	  end

	  def user_params
		params.require(:user).permit(:full_name, :email, :password_digest, :password, :password_confirmation, :role)
	  end
end
