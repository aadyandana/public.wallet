module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :handle_internal_error
    rescue_from ActionController::ParameterMissing, with: :handle_bad_request_error
    rescue_from UnauthorizedError, with: :handle_unauthorized_error
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found_error
    rescue_from ActiveRecord::RecordInvalid, with: :handle_unprocessable_content_error
  end

  private
  def handle_internal_error(e)
    error_response(e.message)
  end

  def handle_bad_request_error(e)
    error_response(e.message, StatusCode::BAD_REQUEST)
  end

  def handle_unauthorized_error(e)
    error_response(e.message, StatusCode::UNAUTHORIZED)
  end

  def handle_not_found_error(e)
    error_response(e.message, StatusCode::NOT_FOUND)
  end

  def handle_unprocessable_content_error(e)
    error_response(e.message, StatusCode::UNPROCESSABLE_ENTITY)
  end
end
