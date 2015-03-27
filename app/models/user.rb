# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  name             :string
#  email            :string
#  password_digest  :string
#  avatar           :text
#  guess_count      :integer          default("0")
#  is_admin         :boolean          default("false")
#  provider         :string
#  uid              :string
#  oauth_token      :string
#  oauth_expires_at :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class User < ActiveRecord::Base
  has_secure_password
  has_many :likes
  has_many :places, through: :likes
  validates :name, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
end
