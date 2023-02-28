class Ride < ApplicationRecord
  belongs_to :amusement_park

  has_many :ride_mechanics
  has_many :mechanics, through: :ride_mechanics
  
  validates_presence_of :name, :thrill_rating, :open
  validates_numericality_of :thrill_rating
end