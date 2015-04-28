class ApplicationsController < ApplicationController
  def create
    @application = Application.create
    flash[:notice] = "Application successfully submitted."
    redirect_to root_url
  end
end
