class JobsController < ApplicationController
  def index
    @filter = Job.ransack(params[:q])
    @jobs = @filter.result(distinct: true)
  end

  def new
    if logged_in?
      @job = Job.new
    else
      flash[:error] = "You must be logged in to create a job."
      redirect_to '/login'
    end
  end

  def edit
    job = Job.find(params[:id])
    if current_user == job.user
      @job = job
    else
      flash[:error] = "You must be logged in to edit a job."
      redirect_to '/login'
    end
  end

  def update
    job = Job.find(params[:id])
    if current_user == job.user
      if job.update!(job_params)
        flash[:notice] = "Updated job."
        redirect_to root_url
      end
    else
      flash[:error] = "You must be logged in to edit a job."
      redirect_to '/login'
    end
  end

  def destroy
    job = Job.find(params[:id])
    if current_user == job.user
      if job.destroy
        flash[:notice] = "Deleted job."
        redirect_to root_url
      end
    else
      flash[:error] = "You must be logged in to delete a job."
      redirect_to '/login'
    end
  end

  def create
    @job = Job.new(job_params)
    @job.user_id = current_user.id if logged_in?
    if @job.save
      flash[:notice] = "Created job."
      redirect_to root_url
    else
      flash[:error] = @job.errors.full_messages[0]
      render :action => 'new'
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  private
    def job_params
      params.require(:job).permit(:title, :term_id, :location, :experience_id, :majors, :description, :url, :instructions, :deadline, :salary)
    end
end
