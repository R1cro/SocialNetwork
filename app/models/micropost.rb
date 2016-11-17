class Micropost < ApplicationRecord
  HASHTAG_REGEX = /(?:(?<=\s)|^)#(\w*[A-Za-z_]+\w*)/i
  belongs_to :user
  has_many :likes, dependent: :destroy
  acts_as_taggable_on :tags
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }, allow_nil: false
  validate  :image_size
  before_create :save_hashtags

  def liked_by?(user)
     self.likes.where(user: user).present?
  end

  private
  def save_hashtags
    tags = self.content.scan(HASHTAG_REGEX)
    self.tag_list.add(tags)
  end

  def image_size
    if image.size > 10.megabyte
      errors.add(:image, 'Image size should be less than 10 MB!')
    end
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end
end
