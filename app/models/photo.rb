# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  image      :text
#  place_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Photo < ActiveRecord::Base
  belongs_to :place
end
