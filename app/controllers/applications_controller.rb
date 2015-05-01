class ApplicationsController < ApplicationController
  def index
    if !params[:job_id].nil? and current_user == Job.find(params[:job_id]).user
      @applications = Application.where(job_id: params[:job_id])
      @job = Job.find(params[:job_id])
    else
      flash[:error] = "You are not authorized to view these applications."
      redirect_to(root_url)
    end
  end

  def show
    if current_user == Application.find(params[:id]).job.user
      @application = Application.find(params[:id])
    else
      flash[:error] = "You are not authorized to view this application."
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

  private
      def application_params
        params.require(:application).permit(:user_id, :job_id)
      end
end
