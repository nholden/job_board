class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log in
    else
      flash.now[:error] = "Email and password combination not recognized."
      render 'new'
    end
  end

  def destroy
  end
end
