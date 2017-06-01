class Computer < ApplicationRecord
  belongs_to :computer, optional: true
  alias_attribute :parent, :computer

  enum status: [ :in_use, :available, :junk ]
end
