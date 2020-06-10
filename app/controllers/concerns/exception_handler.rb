# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :missing_token
    rescue_from ExceptionHandler::InvalidToken, with: :invalid_token

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :record_invalid)
    end
  end

  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  def missing_token(e)
    json_response({ message: e.message }, :missing_token)
  end

  def invalid_token(e)
    json_response({ message: e.message }, :invalid_token)
  end

  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end
end
