class Admin::UsersController < Admin::BaseController
  before_action :require_user, only: [:show, :edit]

  def show
    @user = User.find(current_user.id)
    @status_count = Order.status_count
    if params[:filter_by_status]
      @orders = Order.filter_by_status(params[:filter_by_status]).order(:id)
    else
      @orders = Order.order(:id)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user = User.update(user_params)
      flash[:notice] = "Account Updated"
      redirect admin_user_path(@user)
    else
     redirect_to admin_dashboard_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :username, :password, :role)
    end
end
