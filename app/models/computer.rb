class Computer < ApplicationRecord
  belongs_to :computer
  alias_attribute :parent, :computer
end
