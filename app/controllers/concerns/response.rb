module Response
  extend ActiveSupport::Concern

  included do
    def standard_response(data = {}, status = StatusCode::OK)
      render json: { status: status, data: data }, status: status
    end

    def error_response(message, status = StatusCode::INTERNAL_SERVER_ERROR)
      render json: { status: status, error: message }, status: status
    end
  end
end
