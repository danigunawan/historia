class LikesController < ApplicationController
  def index
  end

  def new
    @like = Like.new
    @place = Place.find_by :id => @photo[:place_id]
  end

  # def create
  #   @current_user = User.find_by :id => session[:user_id]
  #   like = @current_user.likes.create(place_id: @place) like_params
  #   redirect_to root_path
  # end

  # def like
  #   type = params[:type]
  #   current_user = User.find_by :id => session[:user_id]

  #   if type == "like"
  #     current_user.likes << @place
  #     redirect_to :back, notice: 'You liked #{@place.name}'
      
  #   elsif type == "unlike"
  #     current_user.likes.delete(@place)
  #     redirect_to :back, notice: 'You unliked #{@place.name}'
  #   else
  #     # Type missing, nothing happens
  #     redirect_to :back, notice: 'Nothing happened.'
  #   end
  # end

  def destroy
  end

  private
  def like_params
    params.require(:like).permit(:place_id)
  end
end
