class PagesController < ApplicationController
  def index
    @place = Place.random
    # binding.pry
  end   
end
