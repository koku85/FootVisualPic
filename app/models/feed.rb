class Feed < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true
  validates :image, presence: true
  validates :user_id, presence: true
end
