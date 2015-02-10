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
    if @user.save
      flash[:notice] = "Created employer account."
      log_in(@user)
      redirect_to root_url
    else
      flash[:error] = @user.errors.full_messages[0]
      render :action => 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :website, :role_id)
    end
end
