class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: Settings.MAX_LENGTH_NAME }
  validates :email, presence: true, length: { maximum: Settings.MAX_LENGTH_EMAIL },
                    format: { with: Settings.VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: Settings.MIN_LENGTH_PASSWORD }, allow_nil: true

  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
