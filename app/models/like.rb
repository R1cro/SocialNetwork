class Like < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :micropost, uniqueness: { scope: :user }
end
