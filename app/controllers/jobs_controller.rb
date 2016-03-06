class JobsController < ApplicationController
  def index
    params[:q] ||= {}
    @checked_experiences = params[:q][:experience_id_eq_any] || []
    @checked_terms = params[:q][:term_id_eq_any] || []
    @filter = Job.ransack(params[:q])
    @jobs = @filter.result(distinct: true).paginate(:page => params[:page], :per_page => 10)
  end

  def new
    if logged_in?
      if current_user.role.label == "applicant"
        flash[:error] = "Applicants can't create jobs."
        redirect_to root_url
      else
        @job = Job.new
      end
    else
      flash[:error] = "You must be logged in to create a job."
      redirect_to '/login'
    end
  end

  def edit
    job = Job.find(params[:id])
    if current_user == job.user or is_admin?
      @job = job
    else
      flash[:error] = "You must be logged in to edit a job."
      redirect_to '/login'
    end
  end

  def update
    job = Job.find(params[:id])
    if current_user == job.user or is_admin?
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
    if current_user == job.user or is_admin?
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
    if logged_in?
      existing_application = Application.where("user_id = ? AND job_id = ?", current_user.id, @job.id).first
      if existing_application.nil?
        @application = Application.new
      else
        @application = existing_application
      end
    end
  end

  private
    def job_params
      params.require(:job).permit(:title, :term_id, :location, :experience_id, :majors, :description, :url, :instructions, :deadline, :salary)
    end
end
