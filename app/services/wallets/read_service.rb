module Wallets
  class ReadService
    def initialize(params)
      @owner_type = params[:owner_type]
    end

    def call
      ActiveRecord::Base.transaction do
        wallets = Wallet.all

        wallets = wallets.where(owner_type: @owner_type.upcase) if @owner_type

        wallets
      rescue ActiveRecord::ActiveRecordError => e
        raise e
      end
    end
  end
end
