class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates :image, presence: true
  has_many :feeds, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
