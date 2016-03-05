class UserApplicationsController < ApplicationController
  def index
    if logged_in?
      @applications = Application.where(user_id: current_user.id)
    else
      flash[:error] = "You must be logged in to view your applications."
      redirect_to root_url
    end
  end
end
