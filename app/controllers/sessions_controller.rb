class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by :email => params[:email].downcase
    if user.present? && user.authenticate(params[:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
      # log_in user
      # params[:remember_me] == '1' ? remember(user) : forget(user)
      # redirect_to root_path, sucess: "You've successfully signed in."
    else
      flash.now[:error] = "Oops! The wrong email or password was entered. Try again."
      redirect_to root_path # Need to change this to render the login page
    end
  end
  
  def create_social
    user = User.from_omniauth(env["omniauth.auth"])
    if user.present?
      log_in user
      flash[:success] = "You've successfully signed in."
      redirect_to root_path   
    else
      flash.now[:error] = "Oops! Login wasn't successful. Try again."
      redirect_to root_path # Need to change this to render the login page
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path, notice: "You've successfully signed out."
  end
end
