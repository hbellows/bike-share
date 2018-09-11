class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def show
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to user_path(current_user)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :username, :password, :role)
    end
end
