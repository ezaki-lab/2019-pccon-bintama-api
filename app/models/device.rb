class Device < ApplicationRecord
	validates :token, presence: true, uniqueness: true
end
