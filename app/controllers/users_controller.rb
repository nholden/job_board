class UsersController < ApplicationController
  def new
    if logged_in?
      flash[:error] = "Already logged in."
      redirect_to root_url
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)

    if admin_exists?
      @user.role_id = Role.find_or_create_by(label: 'employer').id
      flash_role = "employer"
    else
      @user.role_id = Role.find_or_create_by(label: 'admin').id
      flash_role = "administrator"
    end

    if @user.save
      flash[:notice] = "Created #{flash_role} account."
      log_in(@user)
      redirect_to root_url
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

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :website)
    end
end
