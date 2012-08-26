class ExperimentsController < ApplicationController
  before_filter :authenticate

  def new
    @experiment = Experiment.new
    @title = "Create new experiment"
  end

  def create
    @experiment = current_user.experiments.build(params[:experiment])
    if @experiment.save
      flash[:success] = "Experiment created!"
      redirect_to current_user
    else
      render 'experiments/new'
    end
  end

  def destroy

  end
end
