class ConditionsController < ApplicationController

  def dashboard
    require_user
    @max_temperature = Condition.max_temp_breakdown
    @precipitation = Condition.precip_breakdown
    @mean_wind_speed = Condition.wind_breakdown
    @mean_visibility = Condition.visibility_breakdown
  end

  def index
    @conditions = Condition.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def destroy
    Condition.destroy(params[:id])
    flash[:notice] = 'Condition deleted.'
    redirect_to conditions_path
  end
end
