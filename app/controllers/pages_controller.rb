class PagesController < ApplicationController
  def index
    @place = Place.random
    respond_to do |format|
      format.html
      format.json
    end
  end  

  def show
    @place = Place.find params[:id]
    respond_to do |format|
      format.html
      format.json
    end
  end 
end
