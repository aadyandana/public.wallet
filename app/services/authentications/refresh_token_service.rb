module Authentications
  class RefreshTokenService
    def initialize(wallet)
      @wallet = wallet
    end

    def call
      ActiveRecord::Base.transaction do
        access_token = Session.where(wallet: @wallet).active.access.first&.token

        if not access_token.present?
          access_token = CustomToken.new(@wallet).call
          create_session(Session::SESSION_TYPE_ACCESS, access_token)
        end

        { access_token: access_token }
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
