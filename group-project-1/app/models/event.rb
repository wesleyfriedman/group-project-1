class Event < ApplicationRecord
	has_many :event_users
	has_many :users, through: :event_users
	has_many :tasks
	has_many :supplies, through: :tasks

end
