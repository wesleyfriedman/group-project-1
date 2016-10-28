class User < ApplicationRecord
	has_secure_password

	has_and_belongs_to_many :events 
	has_many :tasks

	validates :name, presence: true
	validates :email, uniqueness: true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
	validates :phone_number, length: {is: 10}
end
