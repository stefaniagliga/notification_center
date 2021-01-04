# frozen_string_literal: true

class JsonWebToken
  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, hmac_secret)
    end

    def decode(token)
      body = JWT.decode(token, hmac_secret, true, algorithm: 'HS256')[0]
      HashWithIndifferentAccess.new body
    rescue
      nil
    end

    private

    def hmac_secret
      Rails.application.secrets[:jwt_hmac]
    end
  end
end