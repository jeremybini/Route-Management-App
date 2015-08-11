class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  		session[:user_id] = user.id
  		redirect_to gyms_path, notice: "Welcome back!"
  	else
  		flash[:alert] = "Email or password is invalid"
  		render 'new'
  	end
  end

  def destroy
    session[:user_id] = nil
    redirect_to gyms_url, notice: "Logged Out"
  end
end
