class PagesController < ApplicationController
  def index
    @place = Place.random
    respond_to do |format|
      format.html
      format.json
    end
    # binding.pry
  end   
end
