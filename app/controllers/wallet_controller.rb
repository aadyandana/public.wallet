class WalletController < ApplicationController
  skip_before_action :authenticate

  def create
    wallet = Wallets::CreateService.new(wallet_params).call

    standard_response(wallet, StatusCode::CREATED)
  rescue ActionController::ParameterMissing => e
    error_response(e.message, 400)
  rescue ActiveRecord::ActiveRecordError => e
    error_response(e.message, 422)
  rescue => e
    error_response(e.message)
  end

  private
  def wallet_params
    params.require(:wallet).permit(:owner_type)
  end
end
