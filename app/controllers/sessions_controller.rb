class SessionsController < ApplicationController
  def new
  end

  def create
    employer = Employer.find_by(email: params[:session][:email].downcase)
    if employer && employer.authenticate(params[:session][:password])
      # Log in
    else
      flash.now[:error] = "Email and password combination not recognized."
      render 'new'
    end
  end

  def destroy
  end
end
