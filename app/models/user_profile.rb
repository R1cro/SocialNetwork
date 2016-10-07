class UserProfile < ApplicationRecord
  belongs_to :user, inverse_of: :user_profile

  def age(birthday)
    if birthday.present?
      (Time.now.to_s(:number).to_i - birthday.to_time.to_s(:number).to_i)/10e9.to_i
    end
  end
end

