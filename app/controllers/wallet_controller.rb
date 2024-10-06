class WalletController < ApplicationController
  skip_before_action :authenticate

  def index
    wallets = Wallets::ReadService.new(index_params).call

    standard_response(wallets, StatusCode::OK)
  end

  def create
    wallet = Wallets::CreateService.new(create_params).call

    standard_response(wallet, StatusCode::CREATED)
  end

  private
  
  def index_params
    params.permit(:owner_type)
  end
  
  def create_params
    params.require(:wallet).permit(:owner_type)
  end
end
