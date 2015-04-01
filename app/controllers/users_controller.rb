class UsersController < ApplicationController
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
      session[:user_id] = @user.id
      flash[:success] = "You've successfully signed up!"
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by :id => session[:user_id]
  end

  def show
    @user = User.find params[:id]
  end

  def update
    user = @current_user
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :is_admin, :remote_avatar_url)
  end
end
