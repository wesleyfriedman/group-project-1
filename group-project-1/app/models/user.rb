class User < ApplicationRecord
	has_secure_password

	has_many :events, through: :events_users
	has_many :tasks
	has_many :events_users, dependent: :destroy
	#  has_many :hosted_events, classname: "Event", foreign_key: "host_id"

	validates :name, presence: true
	validates :email, uniqueness: true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
	validates :phone_number, length: {is: 10}

	def hosted_events
		self.events.select {|event| event.host == self.id }
	end

	def find_host(event)
		User.find(event.host)
	end

end
