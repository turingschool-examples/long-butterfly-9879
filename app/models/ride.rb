class Ride < ApplicationRecord
  belongs_to :amusement_park
  has_many :ride_mechanics
  has_many :mechanics, through: :ride_mechanics

  def self.average_mechanic_experience
    joins(:mechanics).select("rides.*, avg(years_experience) as average").group(:id).order(:average)
  end
end