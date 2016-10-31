class Supply < ApplicationRecord
	belongs_to :task
	validates :name, presence: true
	validates :quantity, numericality: { greater_than: 0 }
	validates :unit_cost, numericality: { greater_than_or_equal_to: 0 }

	# budget (how much is left)
	# total

end
