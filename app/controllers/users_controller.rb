class UsersController < ApplicationController
  def index
    @users = User.all.decorate
  end

  def edit
    @user = User.find(params[:id]).decorate
  end

  def update
    @user = User.find(params[:id]).decorate
    if @user.update_attributes(user_params)
      redirect_to users_path, notice: "User updated!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:salary, :level)
  end
end
