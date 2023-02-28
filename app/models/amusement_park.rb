class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanics, -> { distinct }, through: :rides 
end