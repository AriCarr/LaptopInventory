class Computer < ApplicationRecord
  belongs_to :computer, optional: true
  alias_attribute :parent, :computer
end
