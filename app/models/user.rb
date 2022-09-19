class User < ApplicationRecord
  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: Settings.MAX_LENGTH_NAME }
  validates :email, presence: true, length: { maximum: Settings.MAX_LENGTH_EMAIL },
                    format: { with: Settings.VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: Settings.MIN_LENGTH_PASSWORD }

  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
