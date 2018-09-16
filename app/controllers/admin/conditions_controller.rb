class Admin::ConditionsController < ApplicationController

  def index
    @conditions = Condition.paginate(:page => params[:page], :per_page => 30)
  end

  def new
    @condition = Condition.new
  end

  def create
    @condition = Condition.new(condition_params)
    @condition.date = Date.strptime(condition_params[:date], '%m/%d/%Y')
    if @condition.save
      flash[:notice] = 'New condition added!'
      redirect_to condition_path(@condition)
    else
      flash[:notice] = 'Condition was not created.'
      redirect_to new_admin_condition_path
    end
  end

  def edit
    @condition = Condition.find(params[:id])
  end

  def update
    @condition = Condition.find(params[:id])
    @condition.update(condition_params)
    @condition.date = Date.strptime(condition_params[:date], '%m/%d/%Y')
    if @condition.save
      flash[:notice] = 'Condition updated!'
      redirect_to condition_path(@condition)
    else
      flash[:notice] = 'Condition was not updated.'
      redirect_to edit_admin_conition_path(@condition)
    end
  end

  def destroy
    Condition.destroy(params[:id])
    flash[:notice] = 'Condition deleted.'
    redirect_to admin_conditions_path
  end


  private
    def condition_params
      params.require(:condition).permit(:date, :max_temperature, :mean_temperature, :min_temperature,
        :mean_humidity, :mean_visibility, :mean_wind_speed, :precipitation)
    end
end
