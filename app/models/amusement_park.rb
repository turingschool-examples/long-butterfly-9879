class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanics, through: :rides

  def average_experience
    require 'pry'; binding.pry
    joins(:mechanics).select().avg(:years_experience)
  end
end