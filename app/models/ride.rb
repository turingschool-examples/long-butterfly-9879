class Ride < ApplicationRecord
  belongs_to :amusement_park
  has_many :mechanic_rides
  has_andbelongs_to_many :mechanics, through: :mechanic_rides
end