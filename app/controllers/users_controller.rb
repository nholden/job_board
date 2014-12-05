class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Created employer account."
      redirect_to root_url
    else
      flash[:error] = @user.errors.full_messages[0]
      render :action => 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :website)
    end
end
