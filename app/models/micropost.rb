class Micropost < ApplicationRecord
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :content

  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }, allow_nil: false
  validate  :image_size

  private
  def image_size
    if image.size > 10.megabyte
      errors.add(:image, 'Image size should be less than 10 MB!')
    end
  end

end
