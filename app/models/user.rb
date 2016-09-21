class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  PASSWORD_FORMAT = /\A(?=.*\d)/i

  attr_accessor :remember_token, :reset_token, :activation_token

  before_save :downcase_email
  before_create :create_activation_digest

  validates :email, presence: true, length: { maximum: 40 },
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence:  true, length: { minimum: 6 },
                                    format: { with: PASSWORD_FORMAT },  allow_nil: true

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

  # def authenticated?(remember_token)
  #   if remember_digest.nil?
  #     false
  #   else
  #     BCrypt::Password.new(remember_digest).is_password?(remember_token)
  #   end
  # end
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    if digest.nil?
      false
    else
      BCrypt::Password.new(digest).is_password?(token)
    end
  end


  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:forgot_password_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.forgot_password(self).deliver
  end

  def password_reset_expired?
    if reset_digest.nil?
      true
    else
      forgot_password_at < 20.minutes.ago
    end
  end

  def age(birthday)
    (Time.now.to_s(:number).to_i - birthday.to_time.to_s(:number).to_i)/10e9.to_i
  end

  def downcase_email
    self.email = email.downcase
  end


  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end