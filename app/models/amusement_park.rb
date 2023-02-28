class AmusementPark < ApplicationRecord
  has_many :rides

  def all_distinct_mechanics
    require 'pry'; binding.pry
    rides.joins(:mechanics)
  end
end