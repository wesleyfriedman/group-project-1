class Event < ApplicationRecord

	has_many :users, through: :events_users
	has_many :tasks
	has_many :supplies, through: :tasks
	has_many :events_users

	validates :name, presence: true
	validates :address, presence: true

	def date_format(date)
		date.strftime("%A - %B %y, %Y at %I:%M %p")
	end

end
