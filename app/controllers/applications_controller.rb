class ApplicationsController < ApplicationController
  def create
    @application = Application.new(application_params)
    job_title = Job.find(application_params[:job_id]).title
    if @application.save
      flash[:notice] = "Application to '#{job_title}' successfully submitted."
      redirect_to root_url
    end
  end

  private
      def application_params
        params.require(:application).permit(:user_id, :job_id)
      end
end
