class User < ApplicationRecord
	has_secure_password
	has_many :tasks
	has_many :event_users
	has_many :events, through: :event_users
end
