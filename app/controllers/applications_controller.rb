class ApplicationsController < ApplicationController
  def create
    if !logged_in?
      flash[:error] = "You must be logged in to apply."
      redirect_to login_path
    elsif current_user.role.label == "applicant"
      @application = Application.new(application_params)
      job_title = Job.find(application_params[:job_id]).title
      if @application.save
        flash[:notice] = "Application to '#{job_title}' successfully submitted."
        redirect_to root_url
      end
    end
  end

  private
      def application_params
        params.require(:application).permit(:user_id, :job_id)
      end
end
