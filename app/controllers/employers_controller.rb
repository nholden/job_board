class EmployersController < ApplicationController
  def new
    @employer = Employer.new
  end

  def create
    @employer = Employer.new(employer_params)
    if @employer.save
      flash[:notice] = "Created employer account."
      redirect_to root_url
    else
      flash[:alert] = "Did not create employer account."
      redirect_to 'employers#new'
    end
  end

  private
    def employer_params
      params.require(:employer).permit(:email, :password, :password_confirmation, :name, :description, :website)
    end
end
