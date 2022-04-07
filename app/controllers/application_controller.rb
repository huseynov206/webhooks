# frozen_string_literal: true

# Base class for all controllers
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include JsonToken

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from JWT::VerificationError, with: :unauthorized
  rescue_from JWT::DecodeError, with: :unauthorized

  before_action :authenticate_request

  private

  def not_found
    render json: { error: 'Not Found' }, status: :not_found
  end

  def unauthorized
    render json: { error: 'unauthorized' }, status: :unauthorized
  end

  def authenticate_request
    header = request.headers['Authorization']
    if header
      header = header.split.last
    else
      unauthorized
      return
    end

    decoded = jwt_decode(header)
    user = User.find_by(id: decoded[:user_id])
    unauthorized unless user
  end
end
