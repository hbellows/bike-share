class Admin::ConditionsController < ApplicationController

  def index
    @conditions = Condition.all
  end

end
