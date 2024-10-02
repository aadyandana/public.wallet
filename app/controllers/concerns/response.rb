module Response
  extend ActiveSupport::Concern

  included do
    def standard_response(data = {}, status = :ok)
      render json: { status: status, data: data }, status: status
    end

    def error_response(message, status = :internal_server_error)
      render json: { status: status, error: message }, status: status
    end
  end
end
