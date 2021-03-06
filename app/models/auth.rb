require 'jwt'

class Auth
  ALGORITHM='HS256'

  def self.encrypt(payload)
    JWT.encode(payload, secret_key, ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(token, secret_key, true, {algorithm: ALGORITHM}).first
  end

  def self.secret_key
    "649ec52f292d6e263a9440bb34c950e9bce4alskdjf2d12b09ff1ceda0713c224b0fe1558b20666e55f997eefba40df6d3b7d1795343dff14509e1e7622c1"
  end
end