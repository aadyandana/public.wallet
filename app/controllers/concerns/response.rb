module Response
  extend ActiveSupport::Concern

  included do
    def standard_response(data = {}, status = 200)
      render json: { status: status, data: data }, status: status
    end

    def error_response(message, status = 500)
      render json: { status: status, error: message }, status: status
    end
  end
end
