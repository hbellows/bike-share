class UsersController < ApplicationController
  before_action :require_user, only: [:show, :edit]

  def show
    @user = User.find(current_user.id)
    if current_admin?
     redirect_to admin_dashboard_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if current_admin?
      @user = User.find(params[:id])
      @user.update(user_params)
      flash[:notice] = "#{@user.username}'s Account Updated"
      redirect_to admin_dashboard_path
    else
      @user = User.find(current_user.id)
      @user.update(user_params)
      flash[:notice] = "#{@user.username}'s Account Updated"
      redirect_to dashboard_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :full_name, :username, :password, :role)
    end
end
