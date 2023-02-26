class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanics, through: :rides

  def list_unqie_mech
    mechanics.distinct
  end
end