class Ride < ApplicationRecord
  belongs_to :amusement_park
	has_many :ride_mechanics
	has_many :mechanics, through: :ride_mechanics

	def self.with_mechanic_average_experience
		left_joins(:mechanics)
		.select("rides.*, AVG(mechanics.years_of_experience) as avg_years")
		.group(:id)
		.order(avg_years: :desc)
	end
end