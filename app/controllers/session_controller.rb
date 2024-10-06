class SessionController < ApplicationController
  skip_before_action :authenticate, only: [ :get_token ]

  def get_token
    id = get_token_params

    wallet = Wallets::ReadByIdService.new(id).call

    data = Authentications::GenerateTokenService.new(wallet).call

    standard_response(data)
  end

  def refresh_token
    data = Authentications::RefreshTokenService.new(current_wallet).call

    standard_response(data)
  end

  private
  def get_token_params
    params.require(:id)
  end
end
