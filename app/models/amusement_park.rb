class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanics, through: :rides

  def park_mechanics
    mechanics.distinct 
  end
end