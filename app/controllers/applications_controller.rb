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
    if logged_in? and current_user.id == application_params[:user_id].to_i
      @application = Application.new(application_params)
      job_title = Job.find(application_params[:job_id]).title
      if @application.save
        flash[:notice] = "Application to '#{job_title}' successfully submitted."
      end
    else
      flash[:error] = "You must be logged in as an applicant to apply."
    end
    redirect_to root_url
  end

  def destroy
    @application = Application.find(params[:id])
    job_title = Job.find(@application.job_id).title
    if logged_in? and current_user.id == @application.user_id
      if @application.destroy
        flash[:notice] = "Application to '#{job_title}' successfully retracted."
      end
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
