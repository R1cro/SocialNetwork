class UserProfile < ApplicationRecord
  belongs_to :user, inverse_of: :user_profile

  mount_uploader :avatar, AvatarUploader

  validate  :avatar_size

  def age(birthday)
    if birthday.present?
      (Time.now.to_s(:number).to_i - birthday.to_time.to_s(:number).to_i)/10e9.to_i
    end
  end

  private
  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "should be less than 5MB")
    end
  end
end

