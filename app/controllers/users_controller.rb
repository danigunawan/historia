class UsersController < ApplicationController
  before_action :check_if_admin, :only => [:index, :destroy]
  # before_action :check_if_validate_user, :only => [:edit, :update]

  def index
    if params[:search]
      @users = User.search(params[:search]).order(:name)
    else
      @users = User.order(:name)
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = "Check your email to activate your account."
      redirect_to root_url
    else
      flash.now[:error] = "Oops! There was a problem with signing up. Try again."
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find params[:id]
  end

  def show
    @user = User.find params[:id]
  end

  def update
    user = User.find params[:id]
    user.update user_params
    redirect_to user
  end

  def destroy
    user = User.find params[:id]
    user.destroy
    redirect_to users_path
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :is_admin, :remember_me, :remote_avatar_url)
  end

  def check_if_admin
    redirect_to(root_path) unless @current_user.present? && @current_user.is_admin?
  end
  def check_if_validate_user
    redirect_to(root_path) unless @current_user.id == User.find params[:id]
  end
end
