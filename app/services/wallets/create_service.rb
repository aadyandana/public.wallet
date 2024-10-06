module Wallets
  class CreateService
    def initialize(params)
      @params = params
    end

    def call
      ActiveRecord::Base.transaction do
        wallet = Wallet.new(@params)

        wallet.save!

        wallet
      rescue ActiveRecord::ActiveRecordError => e
        raise e
      end
    end
  end
end
