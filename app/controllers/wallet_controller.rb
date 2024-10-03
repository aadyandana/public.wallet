class WalletController < ApplicationController
  skip_before_action :authenticate

  def create
    ActiveRecord::Base.transaction do
      wallet = Wallet.new(wallet_params)
      wallet.save!

      render json: { status: 201, data: wallet }, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { status: 422, error: e.message }, status: :unprocessable_entity
    end
  end

  private
  def wallet_params
    params.require(:wallet).permit(:owner_type)
  end
end
