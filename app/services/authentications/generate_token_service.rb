module Authentications
  class GenerateTokenService
    def initialize(wallet)
      @wallet = wallet
    end

    def call
      ActiveRecord::Base.transaction do
        sessions = Session.where(wallet: @wallet).active

        access_token = sessions.access.first&.token
        refresh_token = sessions.refresh.first&.token

        if not refresh_token.present?
          refresh_token = CustomToken.new(@wallet).call
          create_session(Session::SESSION_TYPE_REFRESH, refresh_token)
        end

        if not access_token.present?
          access_token = CustomToken.new(@wallet).call
          create_session(Session::SESSION_TYPE_ACCESS, access_token)
        end

        { access_token: access_token, refresh_token: refresh_token }
      rescue => e
        raise e
      end
    end

    private
    def create_session(type, token)
      ActiveRecord::Base.transaction do
        session_params = { wallet: @wallet, session_type: type, token: token }

        Sessions::CreateService.new(session_params).call
      rescue => e
        raise e
      end
    end
  end
end
