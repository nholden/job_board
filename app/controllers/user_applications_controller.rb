class UserApplicationsController < ApplicationController
  def index
    if logged_in?
      @applications = Application.where(user_id: current_user.id)
    else
      flash[:error] = "You are not authorized to view these applications."
    end
  end
end
