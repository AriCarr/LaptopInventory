class User < ApplicationRecord

  class << self
    def from_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      user.name = auth_hash['info']['name']
      user.email = auth_hash['extra']['raw_info']['mail']
      user.save!
      puts user
      user
    end
  end

end