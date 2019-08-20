class Micropost < ApplicationRecord
  include Hashtags

  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :replies, dependent: :destroy
  # has_one :image, dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, ImageUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }, allow_nil: false
  validate  :image_size

  def liked_by?(user)
     self.likes.where(user: user).present?
  end

  private
  def image_size
    if image.size > 10.megabyte
      errors.add(:image, 'Image size should be less than 10 MB!')
    end
  end

end
