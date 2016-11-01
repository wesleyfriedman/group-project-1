class User < ApplicationRecord
	has_secure_password

	has_many :events, through: :events_users
	has_many :tasks
	has_many :events_users

	validates :name, presence: true
	validates :email, uniqueness: true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
	validates :phone_number, length: {is: 10}

	#host cant make a guest have more than three tasks
	#first_name and last_name

	# def name
	# 	@name = "#{self.first_name } + ' ' +#{self.last_name}"
	# end

	def hosted_events
		self.events.select {|event| event.host == self.id }
	end

	def find_host(event)
		User.find(event.host)
	end

end
