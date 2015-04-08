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
#  remember_digest  :string
#

class User < ActiveRecord::Base
  attr_accessor :remember_token

  has_many :likes
  has_many :places, through: :likes

  # Ensures email uniqueness by downcasing the email attribute.
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

  mount_uploader :avatar, ImageUploader
  
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

  # Used to store the randomly generated token as the remember_digest
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Creates a randomly generated token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Saves the randomly generated token as the remember_digest
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Compares the remember_digest with the remember_token using BCrypt method
  def check_authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Replaces the contents of the remember_digest with nil
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Search across users by name or email address
  def self.search(query)
    where("name ilike ? OR email ilike?  ", "%#{query}%", "%#{query}%")
  end
end
