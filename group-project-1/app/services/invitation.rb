class Invitation 

	attr_reader :user, :event 

	def initialize(user, event)
		@user = user
		@event = event 
	end

	def accepted_invitees
		accepted_invitees_ids = EventsUser.where(event_id: @event.id, accepted: true).pluck(:user_id)
		User.where(id: accepted_invitees_ids)
	end

	def declined_invitees
		declined_invitees_ids = EventsUser.where(event_id: @event.id, accepted: false).pluck(:user_id)
		User.where(id: declined_invitees_ids)
	end

	def pending_invitees
		pending_invitees_ids = EventsUser.where(event_id: @event.id, accepted: nil).pluck(:user_id)
		User.where(id: pending_invitees_ids)
	end

end 