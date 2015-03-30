class PagesController < ApplicationController
  def index
    @place = Place.random
    respond_to do |format|
      format.html
      format.json
    end
    # binding.pry
  end  

  def show
    @place = Place.find params[:id]
    # binding.pry
    respond_to do |format|
      format.html
      format.json
    end
  end 
end
