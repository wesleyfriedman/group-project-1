class Task < ApplicationRecord
	belongs_to :user
	belongs_to :event
	has_many :supplies
	validates :name, presence: true
	validates :description, presence: true

	def find_event(event_id)
		event = Event.find(event_id)
		event.name
	end

	def find_user
		User.find(self.user_id).name
	end

end
