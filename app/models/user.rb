# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  name              :string
#  email             :string
#  password_digest   :string
#  avatar            :text
#  guess_count       :integer          default("0")
#  is_admin          :boolean          default("false")
#  provider          :string
#  uid               :string
#  oauth_token       :string
#  oauth_expires_at  :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  remember_digest   :string
#  activation_digest :string
#  activated         :boolean          default("false")
#  activated_at      :datetime
#  reset_digest      :string
#  reset_sent_at     :datetime
#

class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token

  has_many :likes
  has_many :places, through: :likes

  # Ensures email uniqueness by downcasing the email attribute.
  before_save :downcase_email
  before_create :create_activation_digest

  validates :name,  presence: true, 
                    length: { maximum: 127 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, 
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true,
                       confirmation: true,
                       length: { within: 6..64 },
                       on: :create

  mount_uploader :avatar, ImageUploader

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
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
      user.activated = true
      user.activated_at = Time.zone.now
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
  def check_authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
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

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private
  
  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
