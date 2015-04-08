class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :authenticate 
  
  # helper_method :current_user

  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

  private 

    def authenticate 
      if session[:user_id].present?
        @current_user = User.find_by :id => session[:user_id]
      end

      session[:user_id] = nil unless @current_user.present?
    end
end
