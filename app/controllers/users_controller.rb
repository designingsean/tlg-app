class UsersController < ApplicationController
  def index
    @active_users = Users.active
    @inactive_users = Users.inactive
  end

  def create
    @new_user = Users.new(user_params)
    if @new_user.save
      flash[:success] = "User created"
    else
      flash[:error] = "User not created"
    end
    redirect_to controller: "users", action: "index"
  end

  def edit
    user = Users.find(params[:id])
    user.toggle(:active)
    if user.save
      flash[:success] = "User updated"
    else
      flash[:error] = "User not updated"
    end
    redirect_to controller: "users", action: "index"
  end

  private
    def user_params
      params.require(:user).permit(:name)
    end
end
