class Admin::ConditionsController < ApplicationController

  def index
    @conditions = Condition.all
  end

  # def show
  #   @condition = Condition.find(params[:id])
  # end

  def new
    @condition = Condition.new
  end

  def create
    @condition = Condition.new(condition_params)
    @condition.start_date = Date.strptime(condition_params[:start_date], '%m/%d/%Y')
    if @condition.save
      flash[:notice] = 'New condition added!'
      redirect_to condition_path(@condition)
    else
      flash[:notice] = 'Condition was not created.'
      redirect_to new_admin_condition_path
    end
  end

  private

    def condition_params
      params.require(:condition).permit(:date, :dock_count, :city, :installation_date)
    end

end
