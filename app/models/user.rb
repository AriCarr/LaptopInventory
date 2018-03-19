class User < ApplicationRecord
  has_many :computers

  class << self
    def from_omniauth(auth_hash)
      u = find_or_create_by(name: auth_hash['info']['name'], email: auth_hash['extra']['raw_info']['mail'].downcase)
      if u.email == ENV['PRESEED_ADMIN_EMAIL']
        u.is_admin = true
        u.save!
      end
      u
    end
  end

end
