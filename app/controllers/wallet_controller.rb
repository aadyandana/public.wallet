class WalletController < ApplicationController
  skip_before_action :authenticate

  def create
    wallet = Wallets::CreateService.new(wallet_params).call

    standard_response(wallet, StatusCode::CREATED)
  end

  private
  def wallet_params
    params.require(:wallet).permit(:owner_type)
  end
end
