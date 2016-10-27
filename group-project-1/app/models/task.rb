class Task < ApplicationRecord
	belongs_to :user
	belongs_to :event
	has_many :supplies
	validates :name, presence: true 
end
