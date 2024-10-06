class ApplicationController < ActionController::API
  include Response
  include ErrorHandler

  before_action :authenticate

  def authenticate
    raise UnauthorizedError.new "Unauthorized: No Authorization Found" if not request.headers["Authorization"].present?

    authorizations = request.headers["Authorization"]&.split(" ")

    raise UnauthorizedError.new "Unauthorized: Not Bearer Authorization" if not authorizations&.first == "Bearer"

    token = authorizations&.last

    session = get_session(token)

    raise UnauthorizedError.new "Unauthorized: No Session Found" if not session.present?
    raise UnauthorizedError.new "Unauthorized: #{session.session_type.capitalize} Token Expired" if session.expired_at < Time.current

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
