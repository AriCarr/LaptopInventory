class User < ApplicationRecord
  has_many :computers
  validates :email, presence: true, format: { with: /\b[A-Z0-9._%a-z\-]+@fsenet\.com\z/}

  class << self
    def from_omniauth(auth_hash)
      find_or_create_by(name: auth_hash['info']['name'], email: auth_hash['extra']['raw_info']['mail'])
    end
  end

end
