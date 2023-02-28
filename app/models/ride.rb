class Ride < ApplicationRecord
  belongs_to :amusement_park
	has_many :mechanics_rides
	has_many :mechanics, through: :mechanics_rides
end