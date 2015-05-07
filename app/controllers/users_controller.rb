class UsersController < ApplicationController
  def new
    if logged_in? && !is_admin?
      flash[:error] = "Already logged in."
      redirect_to root_url
    else
      @role = request.url.split('/')[-1]
      @user = User.new(role: Role.find_or_create_by(label: @role))
    end
  end

  def create
    @user = User.new(user_params)
    @admin_role = Role.find_or_create_by(label:'admin')
    if @user.role_id == @admin_role.id and !is_admin? and !@admin_role.users.blank?
      flash[:error] = "You must be logged in as an administrator to create a new administrator."
      redirect_to '/login'
    elsif @user.save
      flash[:notice] = "Created #{Role.find(@user.role_id).label} account."
      if is_admin?
        redirect_to '/users'
      else
        log_in(@user)
        redirect_to root_url
      end
    else
      flash[:error] = @user.errors.full_messages[0]
      render :action => 'new'
    end
  end

  def edit
    user = User.find(params[:id])
    if current_user == user or is_admin?
      @user = user
    else
      flash[:error] = "You must be logged in to your account to edit your profile."
      redirect_to '/login'
    end
  end

  def update
    user = User.find(params[:id])
    if user == current_user or is_admin?
      if user.update(user_params)
        flash[:notice] = "Updated profile."
        redirect_to root_url
      else
        flash[:error] = user.errors.full_messages[0]
        redirect_to "/users/#{user.id}/edit" 
      end
    else
      flash[:error] = "You must be logged in to your account to edit your profile."
      redirect_to '/login'
    end
  end

  def index
    if !logged_in? or !is_admin?
      flash[:error] = "You must be logged in as an administrator to manage users."
      redirect_to '/login' and return unless logged_in?
      redirect_to root_url
    end
    @users = User.all
  end

  def destroy
    user = User.find(params[:id])
    if !logged_in? or !is_admin?
      flash[:error] = "You must be logged in as an administrator to delete users."
      redirect_to '/login' and return unless logged_in?
      redirect_to root_url and return
    elsif user.destroy
      flash[:notice] = "User deleted."
      redirect_to '/users'
    end
  end

  def delete_resume
    @user = User.find(params[:id])
    if @user == current_user or is_admin?
      @user.resume = nil
      if @user.save
        flash[:notice] = "Resume deleted."
        redirect_to edit_user_path(@user.id)
      end
    else
      flash[:error] = "You must be logged into your account to delete your resume."
      redirect_to '/login'
    end
  end

  def roles
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :website, :role_id, :resume)
    end
end
