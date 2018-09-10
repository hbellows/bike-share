class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password]) && @user.admin?
      session[:user_id] = @user.id
      redirect_to admin_dashboard_path
    elsif @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to login_path
      # render :new
    end
  end
end
