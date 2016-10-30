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

	def accepted_invitees
		accepted_invitees_ids = EventsUser.where(event_id: self.id, accepted: true).pluck(:user_id)
		User.where(id: accepted_invitees_ids)
	end

	def declined_invitees
		declined_invitees_ids = EventsUser.where(event_id: self.id, accepted: false).pluck(:user_id)
		User.where(id: declined_invitees_ids)
	end

	def pending_invitees
		pending_invitees_ids = EventsUser.where(event_id: self.id, accepted: nil).pluck(:user_id)
		User.where(id: pending_invitees_ids)
	end

end
