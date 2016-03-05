class ApplicationsController < ApplicationController
  def index
    @job = Job.find(params[:job_id])
    if current_user == @job.user or is_admin?
      @applications = @job.applications
    else
      flash[:error] = "You are not authorized to view these applications."
      redirect_to(root_url)
    end
  end

  def create
    application = Application.new(application_params)
    if current_user == application.user and application.save
      flash[:notice] = "Application to '#{application.job.title}' successfully submitted."
    else
      flash[:error] = "You must be logged in as an applicant to apply."
    end
    redirect_to root_url
  end

  def destroy
    application = Application.find(params[:id])
    if current_user == application.user and application.destroy
      flash[:notice] = "Application to '#{application.job.title}' successfully retracted."
    else
      flash[:error] = "You must be logged in as an applicant to retract an application."
    end
    redirect_to root_url
  end

  private
      def application_params
        params.require(:application).permit(:user_id, :job_id)
      end
end
