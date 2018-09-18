class Admin::ConditionsController < ApplicationController

  def new
    @condition = Condition.new
  end

  def create
    @condition = Condition.new(condition_params)
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
    if @condition.save
      flash[:notice] = 'Condition updated!'
      redirect_to condition_path(@condition)
    else
      flash[:notice] = 'Condition was not updated.'
      redirect_to edit_admin_condition_path(@condition)
    end
  end

  private
    def condition_params
      params.require(:condition).permit(:date, :max_temperature, :mean_temperature, :min_temperature,
        :mean_humidity, :mean_visibility, :mean_wind_speed, :precipitation)
    end
end
