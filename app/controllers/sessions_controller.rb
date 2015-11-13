class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])

    respond_to do |format|
    	if user && user.authenticate(params[:password])
        if params[:remember_me]
    		  cookies.permanent[:auth_token] = user.auth_token
        else
          cookies[:auth_token] = user.auth_token
        end
        session[:user_id] = user.id
        flash.now[:notice]="Welcome back!"
        format.html { redirect_to root_path }
        format.js { render :js => "window.location.reload()" }
    	else
        @error = "Email or password is invalid"
        format.html { flash.now[:alert] = "Email or password is invalid" }
        format.js { render 'create.js.erb' }
    	end
    end
  end

  def destroy
    cookies.delete(:auth_token)
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged Out"
  end
end
