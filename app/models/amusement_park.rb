class AmusementPark < ApplicationRecord
  has_many :rides
	has_many :mechanics, through: :rides

	def uniq_mechanics
		mechanics.distinct
	end
end