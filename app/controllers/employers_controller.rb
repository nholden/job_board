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
      flash[:error] = @employer.errors.full_messages[0]
      render :action => 'new'
    end
  end

  private
    def employer_params
      params.require(:employer).permit(:email, :password, :password_confirmation, :name, :description, :website)
    end
end
