class ConditionsController < ApplicationController

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
