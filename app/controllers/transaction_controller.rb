class TransactionController < ApplicationController
  def top_up
    ActiveRecord::Base.transaction do
      transaction = Transaction.new(top_up_params)
      transaction.receiver_wallet = @wallet

      transaction.save!

      standard_response(transaction.receiver_wallet.balance)
    rescue ActiveRecord::RecordInvalid => e
      error_response(e.message, StatusCode::UNPROCESSABLE_ENTITY)
    end
  end

  def transfer
    ActiveRecord::Base.transaction do
      transaction = Transaction.new(transfer_params)
      transaction.sender_wallet = @wallet

      transaction.save!

      standard_response(transaction.receiver_wallet.balance)
    rescue ActiveRecord::RecordInvalid => e
      error_response(e.message, StatusCode::UNPROCESSABLE_ENTITY)
    end
  end

  private
  def top_up_params
    transaction_params = params.require(:transaction).permit(:receiver_wallet_id, :amount)

    add_transaction_type(transaction_params)
  end

  def transfer_params
    transaction_params = params.require(:transaction).permit(:sender_wallet_id, :receiver_wallet_id, :amount)

    add_transaction_type(transaction_params)
  end

  def add_transaction_type(transaction_params)
    transaction_params[:transaction_type] = params[:action]

    transaction_params
  end
end
