class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  PASSWORD_FORMAT = /\A(?=.*\d)/i
  before_save { email.downcase! }
  # validates :nickname, presence: true, length: { maximum: 15 },
  #                                      uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 40 },
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence:  true, length: { minimum: 6 },
                                    format: { with: PASSWORD_FORMAT }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
