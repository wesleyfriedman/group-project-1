class Event < ApplicationRecord
	has_many :event_users
	has_many :users, through: :event_users
	has_many :supplies
	has_many :tasks
end
