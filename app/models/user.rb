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
  has_many :likes
  has_many :places, through: :likes

  # Ensure email uniqueness by downcasing the email attribute.
  before_save { self.email = email.downcase }

  validates :name,  presence: true, length: { maximum: 127 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..64},
                       :on => :create
                       
  # Create user account when signing in using Facebook for the first time
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = auth.uid
      user.password_confirmation = auth.uid
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
