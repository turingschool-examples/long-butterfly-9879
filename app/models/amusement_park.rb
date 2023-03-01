class AmusementPark < ApplicationRecord
  has_many :rides

  def unique_mechanics
    self.rides.joins(:mechanics).select('mechanics.*').distinct
  end
end