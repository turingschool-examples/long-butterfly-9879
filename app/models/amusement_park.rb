class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanics, through: :rides

  def list_mechanics_uniq
    self.mechanics.distinct
  end
end