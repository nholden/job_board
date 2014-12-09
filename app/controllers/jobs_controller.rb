class JobsController < ApplicationController
  def index
  end

  def new
    if logged_in?
      @job = Job.new
    else
      flash[:error] = "You must be logged in to create a job."
      redirect_to '/login'
    end
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
      params.require(:job).permit(:title, :term, :location, :experience, :majors, :description, :url, :instructions, :deadline, :salary)
    end
end
