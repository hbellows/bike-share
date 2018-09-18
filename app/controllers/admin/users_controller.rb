class Admin::UsersController < Admin::BaseController
  def show
    @user = User.find(current_user.id)
    @status_count = Order.status_count
    if params[:filter_by_status]
      @orders = Order.filter_by_status(params[:filter_by_status]).order(:id)
    else
      @orders = Order.order(:id)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to admin_dashboard_path
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
      redirect_to admin_dashboard_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'User deleted.'
    redirect_to admin_users_path
  end

  private
    def user_params
      params.require(:user).permit(:full_name, :email, :username, :password, :role)
    end
end
