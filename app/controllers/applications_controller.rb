class ApplicationsController < ApplicationController
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
