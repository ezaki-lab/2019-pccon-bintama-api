class User < ApplicationRecord
  validates :user_id, presence: true, uniqueness: true
  validates :password, confirmation: true, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  has_secure_password
end
