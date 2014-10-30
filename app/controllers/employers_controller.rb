class EmployersController < ApplicationController
  def new
    @employer = Employer.new
  end

  def create
    def employer_params
      params.require(:employer).permit(:email, :name, :description, :website)
    end
    Employer.create(employer_params)
    flash[:notice] = "Created employer account."
    redirect_to root_url
  end
end
