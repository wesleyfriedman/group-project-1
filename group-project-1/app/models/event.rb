class Event < ApplicationRecord

	has_and_belongs_to_many :users
	has_many :tasks
	has_many :supplies, through: :tasks

	validates :name, presence: true
	validates :address, presence: true

	def date_format(date)
		date.strftime("%A - %B %y, %Y at %I:%M %p")
	end

	def self.start_date_data
		<<-SQL
		SELECT start_date
		FROM events
		GROUP BY start_date;
		SQL
	end

end
