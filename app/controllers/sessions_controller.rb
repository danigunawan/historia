class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by :email => params[:email]
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = "Oops! Looks like you've entered the wrong email or password"
      redirect_to root_path
    end
  end
  
  def create_social
    user = User.from_omniauth(env["omniauth.auth"])
    if user.present?
      session[:user_id] = user.id
      redirect_to root_path   
    else
      flash[:error] = "Oops! Login not successful. Try again!"
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
