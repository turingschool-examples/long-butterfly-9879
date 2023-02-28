class AmusementPark < ApplicationRecord
  has_many :rides

  validates_presence_of :name, :admission_cost
  validates_numericality_of :admission_cost
end