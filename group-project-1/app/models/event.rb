class Event < ApplicationRecord
	has_many :event_users
	has_many :users, through: :event_users
	has_many :tasks
	has_many :supplies, through: :tasks

	validates :name, presence: true
	validates :address, presence: true
	# validate: date?

	def date_format(date)
		date.strftime("%A - %B %y, %Y at %I:%M %p")
	end

	# def end_date_format
	# 	self.end_date.strftime("%A - %B %y, %Y at %I:%M %p")
	# end

end
