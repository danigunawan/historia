class PlacesController < ApplicationController
  before_action :check_if_admin, :except => [:index, :like, :show]

  def index
    if params[:search]
      @places = Place.search(params[:search]).order(:name)
    else
      @places = Place.order(:name)
    end
  end

  def like
    type = params[:type]
    current_user = User.find_by(:id => session[:user_id])
    @place = Place.find(params[:id])

    if type == "like"
      like = Like.new(:place => @place)
      current_user.likes << like
      render json: {place_id: @place, user_id: like.user_id} 

    elsif type == "unlike"
      like = current_user.likes.where(place: @place)
      like.destroy(like) if like
      render json: {place_id: @place}
      
    else
      # Error handling needed
      render json: {place_id: @place}
    end
  end

  def create
    @place = Place.create place_params
    redirect_to root_path
  end

  def new
    @place = Place.new
  end

  def edit
    @place = Place.find params[:id]
  end

  def show
    @place = Place.find params[:id]
  end

  def update
    place = Place.find params[:id]
    place.update place_params
    redirect_to root_path
  end

  def destroy
    place = Place.find params[:id]
    place.destroy
    redirect_to places_path
  end

  private 
  def place_params
    params.require(:place).permit(:name, :latitude, :longitude, :image, :fact, :content, :remote_image_url)
  end

  def check_if_admin
    redirect_to(root_path) unless @current_user.present? && @current_user.is_admin?
  end
end
