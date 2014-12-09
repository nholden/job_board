class JobsController < ApplicationController
  def index
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      flash[:notice] = "Created job."
      redirect_to root_url
    else
      flash[:error] = @job.errors.full_messages[0]
      render :action => 'new'
    end
  end

  private
    def job_params
      params.require(:job).permit(:title, :type, :location, :experience, :majors, :description, :url, :instructions, :deadline, :salary)
    end
end
