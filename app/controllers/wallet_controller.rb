class WalletController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      wallet = Wallet.new(wallet_params)
      wallet.save!

      render json: { success: true, data: wallet }, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { success: false, message: e.message }, status: :unprocessable_entity
    end
  end

  private
  def wallet_params
    params.require(:wallet).permit(:owner_type)
  end
end
