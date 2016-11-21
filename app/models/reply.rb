class Reply < ApplicationRecord
  belongs_to :micropost
  belongs_to :user

  validates :content, presence: true, length: { maximum: 200 }, allow_nil: false
  validate  :image_size
  mount_uploader :image, ImageUploader

  def image_size
    if image.size > 10.megabyte
      errors.add(:image, 'Image size should be less than 10 MB!')
    end
  end
end
