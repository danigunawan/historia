# == Schema Information
#
# Table name: places
#
#  id         :integer          not null, primary key
#  name       :string
#  latitude   :float
#  longitude  :float
#  fact       :text
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image      :text
#

class Place < ActiveRecord::Base
  has_many :photos
  has_many :likes
  has_many :users, through: :likes
  
  def self.random
    Place.order("RANDOM()").first
  end

  # mount_uploader :image, ImageUploader

  def self.search(query)
    where("name ilike ? ", "%#{query}%")
  end

end
