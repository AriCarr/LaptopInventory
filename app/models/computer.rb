class Computer < ApplicationRecord
  belongs_to :computer, optional: true
  alias_attribute :parent, :computer
  validates :ram, :processor, :space, numericality: true

  enum status: [ :in_use, :available, :junk ]
  enum manufacturer: [ :"Apple", :"Dell", :"HP", :"Lenovo", :"Microsoft", :"Other" ]
end
