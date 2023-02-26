class Ride < ApplicationRecord
  belongs_to :amusement_park
  has_many :mechanic_rides
  has_many :mechanics, through: :mechanic_rides

  def self.select_unique_mechanics
    joins(:mechanics)
      .select('mechanics.name')
      .distinct.pluck('mechanics.name')
  end

  def self.years_experience_rides
    joins(:mechanics)
      .select('rides.*, AVG(mechanics.years_experience) as average')
      .group(:id)
      .order('average DESC')
  end
end