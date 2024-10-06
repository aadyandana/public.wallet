class ApplicationController < ActionController::API
  include Response

  before_action :authenticate

  def authenticate
    return error_response("Unauthorized: No Authorization Found", StatusCode::UNAUTHORIZED) if not request.headers["Authorization"].present?

    authorizations = request.headers["Authorization"]&.split(" ")

    return error_response("Unauthorized: Not Bearer Authorization", StatusCode::UNAUTHORIZED) if not authorizations&.first == "Bearer"

    token = authorizations&.last

    session = get_session(token)

    return error_response("Unauthorized: No Session Found", StatusCode::UNAUTHORIZED) if not session.present?

    if session.expired_at < Time.current
      return error_response("Unauthorized: #{session.session_type.capitalize} Token Expired", StatusCode::UNAUTHORIZED)
    end

    @wallet = session.wallet
  end

  def current_wallet
    @wallet
  end

  private
  def get_session(token)
    session = Session.where(token: token)
    session = is_refresh_token ? session.refresh : session.access

    session.first
  end

  def is_refresh_token
    params[:controller] == "session" and params[:action] == "refresh_token"
  end
end
