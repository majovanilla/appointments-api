module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two

    rescue_from ActiveRecord::RecordNotFound do |event|
      json_response({ message: event.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |event|
      json_response({ message: event.message }, :unprocessable_entity)
    end
  end

  def four_twenty_two(event)
    json_response({ message: event.message }, :unprocessable_entity)
  end

  def unauthorized_request(event)
    json_response({ message: event.message }, :unauthorized)
  end
end
