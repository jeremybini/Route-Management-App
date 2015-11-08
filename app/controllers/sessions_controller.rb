class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
      if params[:remember_me]
  		  cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      session[:user_id] = user.id
  		redirect_to gyms_path, success: "Welcome back!"
  	else
  		flash[:alert] = "Email or password is invalid"
  		render partial: 'new'
  	end
  end

  def destroy
    cookies.delete(:auth_token)
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged Out"
  end
end
