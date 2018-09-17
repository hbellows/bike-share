class UsersController < ApplicationController
  before_action :require_user, only: [:show, :edit]

  def show
    if current_admin?
      @user = User.find(params[:id])
    elsif current_user
      @user = User.find(current_user.id)
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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "#{@user.username} Updated"
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :full_name, :username, :password, :role)
    end
end
