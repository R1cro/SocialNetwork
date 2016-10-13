class Micropost < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags
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

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end

end
