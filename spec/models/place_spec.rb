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

require 'rails_helper'

RSpec.describe Place, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
