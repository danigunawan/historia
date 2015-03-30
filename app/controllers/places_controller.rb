class PlacesController < ApplicationController
  def index
  end

  def like
    type = params[:type]
    current_user = User.find_by(:id => session[:user_id])
    @place = Place.find(params[:id])

    if type == "like"
      like = Like.new(:place => @place)
      current_user.likes << like
      redirect_to(:back, notice: 'You liked #{@place.name}')
      
    elsif type == "unlike"
      like = current_user.likes.where(place: @place)
      like.destroy(like) if like
      redirect_to(:back, notice: 'You unliked #{@place.name}')

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened.'
    end
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end
end
