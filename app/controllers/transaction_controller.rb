class TransactionController < ApplicationController
  def top_up
    transaction = Transactions::CreateService.new(top_up_params).call

    standard_response(transaction.receiver_wallet.balance)
  end

  def transfer
    transaction = Transactions::CreateService.new(transfer_params).call

    standard_response(transaction.sender_wallet.balance)
  end

  private
  def top_up_params
    transaction_params = params.require(:transaction).permit(:amount)
    transaction_params[:transaction_type] = params[:action]
    transaction_params[:receiver_wallet_id] = @wallet.id

    transaction_params
  end

  def transfer_params
    transaction_params = params.require(:transaction).permit(:receiver_wallet_id, :amount)
    transaction_params[:transaction_type] = params[:action]
    transaction_params[:sender_wallet_id] = @wallet.id

    transaction_params
  end
end
