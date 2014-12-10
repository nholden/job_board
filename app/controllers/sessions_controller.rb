class SessionsController < ApplicationController
  def new
    if logged_in?
      flash[:error] = "Already logged in."
      redirect_to root_url
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:notice] = "Logged in successfully."
      redirect_to root_url 
    else
      flash.now[:error] = "Email and password combination not recognized."
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:notice] = "Logged out successfully."
    redirect_to root_url
  end
end
