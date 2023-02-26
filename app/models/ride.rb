class Ride < ApplicationRecord
  belongs_to :amusement_park
  has_many :mechanics
end