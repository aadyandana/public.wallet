class WalletController < ApplicationController
  skip_before_action :authenticate

  def create
    ActiveRecord::Base.transaction do
      wallet = Wallet.new(wallet_params)
      wallet.save!

      standard_response(wallet, StatusCode::CREATED)
    rescue => e
      error_response(e.message, StatusCode::UNPROCESSABLE_ENTITY)
    end
  end

  private
  def wallet_params
    params.require(:wallet).permit(:owner_type)
  end
end
