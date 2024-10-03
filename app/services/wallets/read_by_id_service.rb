module Wallets
  class ReadByIdService
    def initialize(id)
      @id = id
    end

    def call
      ActiveRecord::Base.transaction do
        wallet = Wallet.find_by(id: @id)

        raise ActiveRecord::RecordNotFound.new "wallet with id #{@id} not found" if wallet.nil?

        wallet
      rescue ActiveRecord::ActiveRecordError => e
        raise e
      end
    end
  end
end
