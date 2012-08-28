class ExperimentsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy

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
    @experiment.destroy
    redirect_back_or root_path
  end

  private
    def authorized_user
      @experiment = Experiment.find(params[:id])
      redirect_to root_path unless current_user?(@experiment.user)
    end
end
