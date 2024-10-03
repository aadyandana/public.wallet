class ApplicationController < ActionController::API
  include Response

  before_action :authenticate

  def authenticate
    authorization = request.headers["Authorization"]&.split(" ")

    return error_response("Unauthorized: No Authorization Found", :unauthorized) if not authorization&.first == "Bearer"
    return error_response("Unauthorized: Not Bearer Authorization", :unauthorized) if not authorization&.first == "Bearer"

    token = authorization&.last

    session = get_session(token)

    return error_response("Unauthorized: No Session Found", :unauthorized) if not session.present?

    if session.expired_at < Time.current
      return error_response("Unauthorized: #{session.session_type.capitalize} Token Expired", :unauthorized)
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
