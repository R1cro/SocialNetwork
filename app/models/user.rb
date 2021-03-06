class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  PASSWORD_FORMAT = /\A(?=.*\d)/i

  attr_accessor :remember_token, :reset_token, :activation_token

  before_save :downcase_email
  before_create :create_activation_digest

  has_many :microposts, dependent: :destroy

  has_many :likes
  has_many :liked_microposts, through: :likes, source: :micropost

  has_many :replies

  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships,  class_name:  'Relationship',
                                    foreign_key: 'followed_id',
                                    dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_one :user_profile, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :user_profile

  has_secure_password
  validates :password, presence:  true, length: { minimum: 6 },
                                    format: { with: PASSWORD_FORMAT },  allow_nil: true

  validates :email, presence: true, length: { maximum: 40 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

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

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    following_ids = 'SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id'
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end
end
