class Admin::UsersController < Admin::BaseController
  before_action :require_user, only: [:show, :edit]

  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.update(user_params)
    flash[:notice] = "Account Updated"
    redirect_to admin_dashboard_path
  end

  private
    def user_params
      params.require(:user).permit(:email, :username, :password, :role)
    end
end
