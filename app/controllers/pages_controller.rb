class PagesController < ApplicationController
  def index
    @photo = Photo.random
  end   
end
