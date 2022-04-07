# frozen_string_literal: true

# Module for JWT actions.
module JsonToken
  require 'jwt'

  extend ActiveSupport::Concern
  SECRET_KEY = Rails.application.secrets.secret_key_base

  def jwt_encode(payload, exp = 1.hour.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def jwt_decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
