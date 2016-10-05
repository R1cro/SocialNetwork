class UserProfile < ApplicationRecord
  belongs_to :user, optional: :city

  def age(birthday)
    (Time.now.to_s(:number).to_i - birthday.to_time.to_s(:number).to_i)/10e9.to_i
  end
end

