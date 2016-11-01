class Invitation

	attr_reader :event

	def initialize(event)
		@event = event
	end

	def accepted_invitees
		accepted_invitees_ids = EventsUser.where(event_id: @event.id, accepted: true).pluck(:user_id)
		User.where("id in (?) or id = ?", accepted_invitees_ids, event.host)
	end

	def declined_invitees
		declined_invitees_ids = EventsUser.where(event_id: @event.id, accepted: false).pluck(:user_id)
		User.where(id: declined_invitees_ids)
	end

	def pending_invitees
		pending_invitees_ids = EventsUser.where(event_id: @event.id, accepted: nil).pluck(:user_id)
		User.where("id in (?) and id != ?", pending_invitees_ids, event.host)
	end

	def exists?(user)
		@event.users.include?(user)
	end

end