class User < ApplicationRecord

  class << self
    def from_omniauth(auth_hash)
        # puts "Keys: #{auth_hash.keys}"
        # auth_hash.keys.each do |k|
        #   puts "#{k}: #{auth_hash[k]}"
        # end
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      user.name = auth_hash['info']['name']
      user.username = auth_hash['extra']['mailNickname']
      user.save!
      puts user
      user
    end
  end

end
