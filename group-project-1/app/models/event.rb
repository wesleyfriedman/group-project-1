class Event < ApplicationRecord

	has_and_belongs_to_many :users
	has_many :tasks, through: :users 
	has_many :supplies, through: :tasks

	validates :name, presence: true
	validates :address, presence: true

	def date_format(date)
		date.strftime("%A - %B %y, %Y at %I:%M %p")
	end

end
