class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  before_filter :sign_in_user, :only => [:new, :create]

  def index
    @title = "All users"
#    @users = User.all
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @experiments = @user.experiments.paginate(:page => params[:page])
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Successfully created your account!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    destroy_user = User.find(params[:id])
    if destroy_user == current_user
      flash[:error] = "Unable to destroy yourself."
    else
      destroy_user.destroy
      flash[:success] = "User destroyed."
    end
    redirect_to users_path
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      if !current_user.nil?
        redirect_to root_path unless current_user.admin?
      else
        redirect_to signin_path
      end
    end

    def sign_in_user
      redirect_to root_path if signed_in?
    end
end
