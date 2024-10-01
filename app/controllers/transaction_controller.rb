class TransactionController < ApplicationController
  def top_up
    ActiveRecord::Base.transaction do
      transaction = Transaction.new(top_up_params)

      transaction.save!

      render json: { status: 201, new_balance: transaction.receiver_wallet.balance }, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { status: 422, error: e.message }, status: :unprocessable_entity
    end
  end

  def transfer
    ActiveRecord::Base.transaction do
      transaction = Transaction.new(transfer_params)

      transaction.save!

      render json: { status: 201, new_balance: transaction.sender_wallet.balance }, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { status: 422, error: e.message }, status: :unprocessable_entity
    end
  end

  private
  def top_up_params
    params.require(:transaction).permit(:receiver_wallet_id, :amount)
  end

  def transfer_params
    params.require(:transaction).permit(:wallet_id, :sender_wallet_id, :receiver_wallet_id, :amount)
  end
end
