class LikesController < ApplicationController
  def new
    @like = Like.new
    @place = Place.find_by :id => @photo[:place_id]
  end

  private
  def like_params
    params.require(:like).permit(:place_id, :user_id)
  end
end
